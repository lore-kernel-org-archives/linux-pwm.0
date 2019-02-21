From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/4] pwm: atmel: add support for SAM9X60's PWM
 controller
Date: Thu, 21 Feb 2019 21:45:04 +0100
Message-ID: <20190221204503.w2xh4rw6rh4e5rg4@pengutronix.de>
References: <1550570914-26391-1-git-send-email-claudiu.beznea@microchip.com>
 <1550570914-26391-4-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550570914-26391-4-git-send-email-claudiu.beznea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Claudiu.Beznea@microchip.com
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Feb 19, 2019 at 10:09:00AM +0000, Claudiu.Beznea@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Add support for SAM9X60's PWM controller.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  drivers/pwm/pwm-atmel.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 647d063562db..229cedb02770 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -52,6 +52,8 @@
>  
>  /* Only the LSB 16 bits are significant. */
>  #define PWM_MAXV1_PRD		0xFFFF
> +/* All 32 bits are significant. */
> +#define PWM_MAXV2_PRD		0xFFFFFFFF
>  #define PRD_MAXV1_PRES		10
>  
>  struct atmel_pwm_registers {
> @@ -311,6 +313,20 @@ static const struct atmel_pwm_data atmel_pwm_data_v2 = {
>  	},
>  };
>  
> +static const struct atmel_pwm_data atmel_pwm_data_v3 = {

Does it make more sense to call this ..._sam9x60 to match the
compatible? (If yes, patch 1 should be changed accordingly.)

I wonder how the naming of the defines is chosen given that pwm_data_v3
is the first that needs PWM_MAXV2_PRD. Looks inconsistent.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
