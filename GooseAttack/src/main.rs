use goose::prelude::*;

fn main() -> Result<(), GooseError> {
    let _goose_metrics = GooseAttack::initialize()?
        .register_taskset(taskset!("LoadtestTasks")
            // Register the greeting task, assigning it a weight of 1.
            .register_task(task!(loadtest_root).set_name("root").set_weight(1)?)
            // Register the random task, assigning it a weight of 1
            .register_task(task!(loadtest_random).set_name("random").set_weight(1)?)
            // Register the random_10 task, assigning it a weight of 1
            .register_task(task!(loadtest_random_100).set_name("random_100").set_weight(1)?)
        )
        .execute()?;

    Ok(())
}

// A task function that loads `/`.
async fn loadtest_root(user: &GooseUser) -> GooseTaskResult {
    let _goose = user.get("/").await?;

    Ok(())
}   

// A task function that loads `/path/to/random`.
async fn loadtest_random(user: &GooseUser) -> GooseTaskResult {
    let _goose = user.get("/random").await?;

    Ok(())
} 

// A task function that loads `/path/to/random?num=100`.
async fn loadtest_random_100(user: &GooseUser) -> GooseTaskResult {
    let _goose = user.get("/random?num=100").await?;

    Ok(())
} 
