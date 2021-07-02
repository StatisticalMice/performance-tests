use goose::prelude::*;

fn main() -> Result<(), GooseError> {
    let _goose_metrics = GooseAttack::initialize()?
        .register_taskset(taskset!("LoadtestTasks")
            .set_wait_time(1, 2).unwrap()
            .register_task(task!(loadtest_greeting).set_name("greeting").set_weight(10)?)
            .register_task(task!(loadtest_random_1000).set_name("random?num=1000").set_weight(10)?)
        )
        .execute()?;

    Ok(())
}

async fn loadtest_greeting(user: &GooseUser) -> GooseTaskResult {
    let _goose = user.get("/greeting").await?;

    Ok(())
} 

async fn loadtest_random_1000(user: &GooseUser) -> GooseTaskResult {
    let _goose = user.get("/random?num=1000").await?;

    Ok(())
} 
