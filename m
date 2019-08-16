From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 4/3] pwm: atmel: document known weaknesses of both
 hardware and software
Date: Fri, 16 Aug 2019 22:43:57 +0200
Message-ID: <20190816204357.GG3545@piout.net>
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
 <20190816093748.11769-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190816093748.11769-1-uwe@kleine-koenig.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc: linux-pwm@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>, Thierry Reding <thierry.reding@gmail.com>, Claudiu Beznea <claudiu.beznea@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 16/08/2019 11:37:48+0200, Uwe Kleine-K=F6nig wrote:
> Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> ---
>  drivers/pwm/pwm-atmel.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> =

> diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> index 42fe7bc043a8..1ddb93db9627 100644
> --- a/drivers/pwm/pwm-atmel.c
> +++ b/drivers/pwm/pwm-atmel.c
> @@ -7,6 +7,16 @@
>   *
>   * Reference manual for "atmel,at91sam9rl-pwm":
>   *   http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-11032-32-bit-=
ARM926EJ-S-Microcontroller-SAM9G25_Datasheet.pdf
> + *
> + * Limitations:
> + * - Periods start with the inactive level.
> + * - Hardware has to be stopped in general to update settings.
> + *
> + * Software bugs/possible improvements:
> + * - When atmel_pwm_apply() is called with state->enabled=3Dfalse a chan=
ge in
> + *   state->polarity isn't honored.
> + * - Instead of sleeping to wait for a completed period, the interrupt
> + *   functionality could be used.

This is definitively not trivial to do right. The main reason it is not
done so is that reading PWM_ISR will clear all the bits so it is
necessary to be very careful to avoid race conditions. I'm not sure it
is worth the effort.


-- =

Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
