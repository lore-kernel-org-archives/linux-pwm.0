From: Bill Pringlemeir <bpringlemeir@nbsps.com>
Subject: Re: [PATCHv6 1/4] pwm: Add Freescale FTM PWM driver support
Date: Thu, 19 Dec 2013 16:55:57 -0500
Message-ID: <87y53gy07m.fsf@nbsps.com>
References: <1384220218-12716-1-git-send-email-Li.Xiubo@freescale.com>
 <1384220218-12716-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1384220218-12716-2-git-send-email-Li.Xiubo@freescale.com> (Xiubo
 Li's message of "Tue, 12 Nov 2013 09:36:55 +0800")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

On 11 Nov 2013, Li.Xiubo at freescale.com wrote:

> +static int fsl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  int duty_ns, int period_ns)
> +{
> +	unsigned long period_cycles, duty_cycles;
> +	unsigned long cntin = FTM_CNTIN_VAL;
> +	struct fsl_pwm_chip *fpc;
> +
> +	fpc = to_fsl_chip(chip);
> +
> +	period_cycles = fsl_rate_to_cycles(fpc, period_ns);
> +	if (period_cycles > 0xFFFF) {
> +		dev_err(chip->dev, "required PWM period cycles(%lu) overflow "
> +				"16-bits counter!\n", period_cycles);
> +		return -EINVAL;
> +	}
> +
> +	duty_cycles = fsl_rate_to_cycles(fpc, duty_ns);
> +	if (duty_cycles >= 0xFFFF) {
> +		dev_err(chip->dev, "required PWM duty cycles(%lu) overflow "
> +				"16-bits counter!\n", duty_cycles);
> +		return -EINVAL;
> +	}
> +
> +	writel(FTMCnSC_MSB | FTMCnSC_ELSB, fpc->base + FTM_CSC(pwm->hwpwm));
> +
> +	writel(0xF0, fpc->base + FTM_OUTMASK);
> +	writel(0x0F, fpc->base + FTM_OUTINIT);
> +	writel(FTM_CNTIN_VAL, fpc->base + FTM_CNTIN);
> +
> +	writel(period_cycles + cntin - 1, fpc->base + FTM_MOD);
> +	writel(duty_cycles + cntin, fpc->base + FTM_CV(pwm->hwpwm));
> +
> +	return 0;
> +}

Even though the module can support eight channels, the FTM_MOD is global
and is updated in each 'config'.  So, if we have two PWMs, and both call
'config' with different periods, the last one to call will win?  There
doesn't seem to be any locking/inspection of 'MOD'.  I think this is
global to the FTM, while 'FTM_CV()' is per channel.

So we may have 8 PWMs, all with the same period, but with different duty
cycles.  Is this correct?  Or are we only supporting one channel per
FTM/PWM?

Thanks,
Bill Pringlemeir.
