import numpy as np
import cv2

def estimate_brain_weight(depth_image_path, pixel_area=1, volume_to_weight_factor=1.05e-3):
    """
    Estimates brain weight from a single depth image.
    
    Args:
        depth_image_path (str): Path to the depth image.
        pixel_area (float): Area represented by each pixel in mm².
        volume_to_weight_factor (float): Conversion factor from volume to weight in grams/mm³.

    Returns:
        float: Estimated brain weight in grams.
    """
    # Load the depth image
    depth_image = cv2.imread(depth_image_path, cv2.IMREAD_GRAYSCALE)
    
    if depth_image is None:
        raise ValueError("Unable to load the depth image. Please check the file path.")
    
    # Normalize depth values (assuming 0-255 maps to 0-100 mm for Kinect V2)
    depth_in_mm = depth_image * (100.0 / 255.0)  # Adjust range as per actual sensor specs
    
    # Calculate approximate volume (sum of depth * pixel area)
    volume_mm3 = np.sum(depth_in_mm) * pixel_area  # Volume in cubic millimeters (mm³)
    
    # Convert volume to brain weight using the factor
    brain_weight = volume_mm3 * volume_to_weight_factor  # Weight in grams
    
    print(f"Debug Info: Total Volume (mm³): {volume_mm3:.2f}")
    print(f"Debug Info: Volume-to-Weight Factor: {volume_to_weight_factor}")
    
    return brain_weight

# Example usage
depth_image_path = 'tst1.png'  # Replace with your image path
estimated_weight = estimate_brain_weight(depth_image_path, pixel_area=1, volume_to_weight_factor=1.05e-3)
print(f"Estimated Brain Weight: {estimated_weight:.2f} grams")
