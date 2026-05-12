CREATE TABLE "ticketFlightsListedAmounts" (
    "ticketNumber" character(13) NOT NULL,
    "flightId" INTEGER NOT NULL,
    "fareCondition" character varying(10) NOT NULL,
    "fareAmount" numeric(10,2) NOT NULL
);

CREATE TABLE "ticketFlightsOtherAmounts" (
    "ticketNumber" character(13) NOT NULL,
    "flightId" INTEGER NOT NULL,
    "fareCondition" character varying(10) NOT NULL,
    "fareAmount" numeric(10,2) NOT NULL
);

CREATE TABLE "bookingTickets" (
    "ticketNumber" character(13) NOT NULL,
    "bookingReference" character(6) NOT NULL,
    "passengerIdentifier" character varying(20) NOT NULL
);