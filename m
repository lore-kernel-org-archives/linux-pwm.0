From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] pwm: stm32-lp: add check in case requested period
 cannot be achieved
Date: Wed, 18 Sep 2019 20:40:39 +0200
Message-ID: <20190918184039.27dtd3zguawijsqo@pengutronix.de>
References: <1568818461-19995-1-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1568818461-19995-1-git-send-email-fabrice.gasnier@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
List-Id: linux-pwm@vger.kernel.org

On Wed, Sep 18, 2019 at 04:54:21PM +0200, Fabrice Gasnier wrote:
> LPTimer can use a 32KHz clock for counting. It depends on clock tree
> configuration. In such a case, PWM output frequency range is limited.
> Although unlikely, nothing prevents user from requesting a PWM frequency
> above counting clock (32KHz for instance):
> - This causes (prd - 1) = 0xffff to be written in ARR register later in
> the apply() routine.
> This results in badly configured PWM period (and also duty_cycle).
> Add a check to report an error is such a case.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

If you are interested to improve the driver further, there are a few
things that I would welcome to see fixed in a tested patch:

 - duty calculation uses requested instead of implemented period.
 - stm32_pwm_lp_apply calls pwm_get_state
 - Calculation of prd could be done without a loop
 - A hint about relevant documentation in the driver's header would be
   great
 - Documentation about behaviour of the hardware is missing:
   - Does the hardware complete the currently running period when
     STM32_LPTIM_CR is cleared?
   - Does the output stop in the inactive output level when the PWM is
     stopped?
 - clk_get_rate might be called without the clock being enabled.
 - The driver does:

 	ret = regmap_write(priv->regmap, STM32_LPTIM_CMP, prd - (1 + dty));

   That looks wrong. (Consider dty == prd.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
