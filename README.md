# Problem Statement

Here is the task

Build APIs for a Reservation management iPad/Mobile application for restaurants using Ruby on Rails as backend:

There should be a guest entity in the system with name and email. — guest must always have name and email

There should be a restaurant entity in the system with name, email and phone. — restaurant must always have name, phone and email. The API shouldn’t accept invalid phone or email formats

Restaurants operate in shifts for example - Morning shift - 9 am to 1 pm, Evening shift - 6pm to 11 pm — Shift end time can’t be less than the start time

There will be tables in restaurants with table name, minimum and maximum number of guests that can sit on them.

Create an API endpoint that creates a reservation for the guest in a restaurant. The API should accept -

The table for reservation, the restaurant shift in which you want the reservation, reservation time -- reservation time must lie within restaurant shift start time and end time, guest who made the reservation, guest count for the reservation -- the guest count must be between maximum and minimum capacity of the table selected for reservation -

When the reservation is created the guest should receive an email with reservation details.

When the reservation is created the restaurant should receive an email with guest details.

Create an API endpoint that updates the reservation - when the reservation details are changed, the guest should receive an email with - old and updated reservation time, old and updated guest count.

**Create an API end point that returns a list of reservations for a restaurant. Reservation should have these fields - Reservation time, guest count, guest name, table name **>b class="">**

Notes:

1. Write test cases.






# Restaurant Reservation Api

**Heroku Link - https://restaurant-reservation-api.herokuapp.com/<br>
**Postman Collection Link - https://www.getpostman.com/collections/c874107058b288d51bfc

<br>
<strong>Requirements</strong>
<br/>
<ul>
  <li>Ruby >= 2.3</li>
  <li>Rails = 5.1.6</li>
</ul>
<br/>

<strong>Run the application in development/test</strong>
<br>
<ul>
  <li>MongoDB must be installed at local or update config/mongoid.yml accordingly</li>
  <li>
    Create a <code>.env</code> file in the root directory. Add the following configuration to it:
    <br>
    ** Change gmail settings to allow signin from less secure apps
    <ul>
      <li>SMTP_USER_NAME = "gmail email" </li>
      <li>SMTP_PASSWORD = "gmail password" </li>
    </ul>
  </li>
  <li><code>bundle install</code></li>
  <li>To run the server: <code>rails server</code></li>
  <li>To run delayed_job (for sending emails): <code>rails jobs:work</code></li>
  <li>To run tests, run <code>rspec .</code></li>
</ul>
<br>

<strong>Gems Used</strong>
<br/>
<dl>
  <dt>All Environments</dt>
  <dd>
    <ul>
      <li>mongoid</li>
      <li>email_validator</li>
      <li>phonelib: Validating IN(Indian - 10/11 digit) phone numbers</li>
      <li>active_model_serializers</li>
      <li>delayed_job_mongoid</li>
    </ul>
  </dd>
  <dt>Development and Test</dt>
  <dd>
    <ul>
      <li>rspec-rails</li>
      <li>database_cleaner</li>
      <li>factory_bot_rails</li>
      <li>dotenv-rails</li>
    </ul>
  </dd>
</dl>
<br/>

<strong>Locales under config/locales</strong>
<br/>
All errors are present in errors/en.yml & all validator_messages are present in validator_messages/en.yml
<br/>
<br/>

<strong>Custom Validators under app/models/validators</strong>
<br>
<ul>
  <li>TimeValidator</li>
</ul>
<br>

<strong>Mongoid Models configuration</strong>
<dl>
  <dt>Restaurant: name, email, phone</dt>
  <dd>
    <ul>
      <li>embeds_many :tables</li>
      <li>embeds_many :shifts</li>
      <li>has_many :reservations</li>
    </ul>
  </dd>
</dl>
<dl>
  <dt>Table: name, maximum_guests, minimum_guests</dt>
  <dd>
    <ul>
      <li>embedded_in :restaurant</li>
      <li>has_many :reservations</li>
    </ul>
  </dd>
</dl>
<dl>
  <dt>Shift: name, start, end</dt>
  <dd>
    <ul>
      <li>embedded_in :restaurant</li>
      <li>has_many :reservations</li>
    </ul>
  </dd>
</dl>
<dl>
  <dt>Guest: name, email</dt>
  <dd>
    <ul>
      <li>embedded_in :reservation</li>
    </ul>
  </dd>
</dl>
<dl>
  <dt>Reservation: time, guest_count</dt>
  <dd>
    <ul>
      <li>belongs_to :restaurant</li>
      <li>belongs_to :shift</li>
      <li>belongs_to :table</li>
      <li>embeds_one :guest</li>
    </ul>
  </dd>
</dl>
<br>

<strong>APIs</strong>
<br>
Base Path : https://restaurant-reservation-api.herokuapp.com/
<ul>
  <li>
    <strong>resources :restaurants</strong>
    <br>
    <ul>
      <li>
        GET /restaurants - #index
      </li>
      <li>
        <dl>
          <dt>POST /restaurants - #create</dt>
          <dd>
            params.require(:restaurant).permit(:name, :email, :phone, shifts_attributes: [:name , :start, :end], tables_attributes: [:name, :minimum_guests, :maximum_guests])
          </dd>
        </dl>
      </li>
      <li>
        GET /restaurants/:id - #show
      </li>
      <li>
        <dl>
          <dt>PUT/PATCH /restaurants/:id - #update</dt>
          <dd>
            params.require(:restaurant).permit(:name, :email, :phone, shifts_attributes: [:name , :start, :end], tables_attributes: [:name, :minimum_guests, :maximum_guests])
          </dd>
        </dl>
      </li>
      <li>
        DELETE /restaurants/:id - #delete
      </li>
    </ul>
  </li>
  <li>
    <strong>resources :shifts</strong>
    <br>
    <ul>
      <li>
        GET /restaurants/:restaurant_id/shifts - #index
      </li>
      <li>
        <dl>
          <dt>POST /restaurants/:restaurant_id/shifts - #create</dt>
          <dd>
            params.require(:shift).permit(:name, :start, :end)
          </dd>
        </dl>
      </li>
      <li>
        GET /restaurants/:restaurant_id/shifts/:id - #show
      </li>
      <li>
        <dl>
          <dt>PUT/PATCH /restaurants/:restaurant_id/shifts/:id - #update</dt>
          <dd>
            params.require(:shift).permit(:name, :start, :end)
          </dd>
        </dl>
      </li>
      <li>
        DELETE /restaurants/:restaurant_id/shifts/:id - #delete
      </li>
    </ul>
  </li>
  <li>
    <strong>resources :tables</strong>
    <br>
    <ul>
      <li>
        GET /restaurants/:restaurant_id/tables - #index
      </li>
      <li>
        <dl>
          <dt>POST /restaurants/:restaurant_id/tables - #create</dt>
          <dd>
            params.require(:table).permit(:name, :minimum_guests, :maximum_guests)
          </dd>
        </dl>
      </li>
      <li>
        GET /restaurants/:restaurant_id/tables/:id - #show
      </li>
      <li>
        <dl>
          <dt>PUT/PATCH /restaurants/:restaurant_id/tables/:id - #update</dt>
          <dd>
            params.require(:table).permit(:name, :minimum_guests, :maximum_guests)
          </dd>
        </dl>
      </li>
      <li>
        DELETE /restaurants/:restaurant_id/tables/:id - #delete
      </li>
    </ul>
  </li>
  <li>
    <strong>resources :reservations</strong>
    <br>
    <ul>
      <li>
        <strong>To get all the reservations of a restaurant</strong>
        <br>
        GET /restaurants/:restaurant_id/reservations - #index
      </li>
      <li>
        <strong>To create a reservations at a restaurant</strong>
        <dl>
          <dt>POST /restaurants/:restaurant_id/reservations - #create</dt>
          <dd>
            params.require(:reservation).permit(:time, :guest_count, :table_id, :shift_id, guest_attributes: [:name, :email])
          </dd>
        </dl>
      </li>
      <li>
        GET /restaurants/:restaurant_id/reservations/:id - #show
      </li>
      <li>
        <strong>To update a reservations at a restaurant</strong>
        <dl>
          <dt>PUT/PATCH /restaurants/:restaurant_id/reservations/:id - #update</dt>
          <dd>
            params.require(:reservation).permit(:time, :guest_count)
          </dd>
        </dl>
      </li>
      <li>
        DELETE /restaurants/:restaurant_id/reservations/:id - #delete
      </li>
    </ul>
  </li>
</ul>
<br>

<strong>Postman collection link for all APIs: </strong>https://www.getpostman.com/collections/c874107058b288d51bfc
