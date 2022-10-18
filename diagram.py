from diagrams import Diagram, Cluster
from urllib.request import urlretrieve
from diagrams.custom import Custom

from diagrams.aws.storage import S3
from diagrams.aws.integration import Eventbridge
from diagrams.aws.integration import StepFunctions
from diagrams.aws.compute import LambdaFunction

with Diagram("S3 Upload Type Check", show=False):
    upload_bucket = S3("upload S3 bucket")
    event_bridge = Eventbridge("Event Bridge")
    lambda_function = LambdaFunction("Lambda Function")
    image_step_function = StepFunctions("Image State Machine")
    video_step_function = StepFunctions("Video State Machine")


    upload_bucket >> event_bridge >> lambda_function >> image_step_function
    lambda_function >> video_step_function