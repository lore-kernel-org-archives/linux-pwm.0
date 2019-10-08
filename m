From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] pwm: stm32: add comment to better describe breakinput
 feature
Date: Tue, 8 Oct 2019 16:45:31 +0200
Message-ID: <20191008144531.pjt525xuz7n5a3hq@pengutronix.de>
References: <1570534887-26181-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1570534887-26181-1-git-send-email-fabrice.gasnier@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: linux-pwm@vger.kernel.org, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: linux-pwm@vger.kernel.org

On Tue, Oct 08, 2019 at 01:41:27PM +0200, Fabrice Gasnier wrote:
> Add a comment to better describe the purpose of breakinput feature that
> can be found on some STM32 timer instances. Briefly comment on the
> characteristics of this input for PWM, and pinmuxing as suggested in [1].
> =

> [1] https://lkml.org/lkml/2019/10/1/207
> =

> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> index 359b085..6406ebb 100644
> --- a/drivers/pwm/pwm-stm32.c
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -522,8 +522,14 @@ static int stm32_pwm_apply_breakinputs(struct stm32_=
pwm *priv,
>  					     sizeof(struct stm32_breakinput));
>  =

>  	/*
> +	 * Some timer instances can have BRK input pins (e.g. basically a fault
> +	 * pin from the output power stage). The break feature allows a safe
> +	 * shut-down of the PWM outputs to a predefined state. Further details
> +	 * are available in application note AN4277, "Using STM32 device PWM
> +	 * shut-down features..."

Without having read the application note I don't understand the purpose.
Not sure if this should be a show stopper though.

>  	 * Because "st,breakinput" parameter is optional do not make probe
> -	 * failed if it doesn't exist.
> +	 * failed if it doesn't exist. The pinctrl handle must hold the BRK
> +	 * pin(s) when using "st,breakinput" property.

Is this a comment that has a better place in the binding doc?

Best regards
Uwe


-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
