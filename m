From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/4] pwm: atmel: add support for controllers with 32 bit
 counters
Date: Tue, 19 Feb 2019 10:15:20 +0100
Message-ID: <20190219091520.4s3hafqxkszmhme2@pengutronix.de>
References: <1548073783-22640-1-git-send-email-claudiu.beznea@microchip.com>
 <1548073783-22640-3-git-send-email-claudiu.beznea@microchip.com>
 <20190219074246.kcdbd5nhf43yw5ax@pengutronix.de>
 <e08cbcb2-4e37-4a2e-ea79-021a2c7a25d6@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e08cbcb2-4e37-4a2e-ea79-021a2c7a25d6@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Feb 19, 2019 at 08:57:04AM +0000, Claudiu.Beznea@microchip.com wrote:
> 
> 
> On 19.02.2019 09:42, Uwe Kleine-König wrote:
> > Hello Claudiu,
> > 
> > On Mon, Jan 21, 2019 at 12:30:53PM +0000, Claudiu.Beznea@microchip.com wrote:
> >> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> >>
> >> New SAM9X60's PWM controller use 32 bits counters thus it could generate
> >> signals with higher period and duty cycles. Update the current driver
> >> to work with old controller (that uses 16 bits counters) and with the
> >> new SAM9X60's controller.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> >> ---
> >>  drivers/pwm/pwm-atmel.c | 38 +++++++++++++++++++++++++++-----------
> >>  1 file changed, 27 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> >> index 7e86a5266eb6..44f4a1c9f60b 100644
> >> --- a/drivers/pwm/pwm-atmel.c
> >> +++ b/drivers/pwm/pwm-atmel.c
> >> @@ -48,15 +48,15 @@
> >>  #define PWMV2_CPRD		0x0C
> >>  #define PWMV2_CPRDUPD		0x10
> >>  
> >> -/*
> >> - * Max value for duty and period
> >> - *
> >> - * Although the duty and period register is 32 bit,
> >> - * however only the LSB 16 bits are significant.
> >> - */
> >> -#define PWM_MAX_DTY		0xFFFF
> >> -#define PWM_MAX_PRD		0xFFFF
> >> -#define PRD_MAX_PRES		10
> >> +/* Max values for period and prescaler */
> >> +
> >> +/* Only the LSB 16 bits are significant. */
> >> +#define PWM_MAXV1_PRD		0xFFFF
> >> +
> >> +/* All 32 bits are significant. */
> >> +#define PWM_MAXV2_PRD		0xFFFFFFFF
> > 
> > This symbol is unused, so I wonder if the patch really does what the
> > commit log promises.
> 
> It is only of SAM9X60's PWM. Please check patch 3/4. Maybe I should have
> been introduced it in there. If you consider it is better to be introduced
> in patch 3/4 please let me know.

Yeah, I think cpp symbols should be introduced with their first user.
And then the commit log should read something like:

	New SAM9X60's PWM controller use 32 bits counters thus it could
	generate signals with higher period and duty cycles compared to
	the already supported implementations that only have 16 bit
	counters. Update the driver to handle counter width depending on
	compatible data. Semantically this is a no-op but it's used in
	the next patch to add support for SAM9X60.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
