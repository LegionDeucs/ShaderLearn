using MyCore.StateMachine;
using Zenject;

public class ApplicationStateMachine : StateMachine<ApplicationStateMachineBaseState, ApplicationContext>
{
    public ApplicationStateMachine(ApplicationContext applicationContext, IInstantiator instantiator) : base(instantiator)
    {
        states = new System.Collections.Generic.Dictionary<System.Type, ApplicationStateMachineBaseState>();

        RegisterState<BootApplicationState>();
        RegisterState<LoadingSceneApplicationState>();
        RegisterState<GameApplicationState>();
    }

    private void RegisterState<TState>()
        where TState : ApplicationStateMachineBaseState
    {
        states.Add(typeof(TState), instantiator.Instantiate<TState>());
    }
}
