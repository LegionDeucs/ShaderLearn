using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.EnhancedTouch;

public class InputSystemProcessor : MonoBehaviour
{
    private InputSystem inputSystem;

    public event System.Action OnLaunchButtonPress;
    private void Awake()
    {
        inputSystem = new InputSystem();
    }

    private void OnEnable()
    {
        inputSystem.PhoneActionMap.Enable();

        inputSystem.PhoneActionMap.ShootButton.performed += ShootButton_performed;

        EnhancedTouchSupport.Enable();
        TouchSimulation.Enable();
    }

    private void ShootButton_performed(InputAction.CallbackContext obj)
    {
        OnLaunchButtonPress?.Invoke();
    }
}
