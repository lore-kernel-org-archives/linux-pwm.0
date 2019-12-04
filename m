From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/2] gpio: mvebu: use platform_irq_count
Date: Wed, 4 Dec 2019 08:24:22 +0100
Message-ID: <20191204072422.vfo3mrrcaav75jv4@pengutronix.de>
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1575433106-16171-1-git-send-email-peng.fan@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peng Fan <peng.fan@nxp.com>
Cc: "rjui@broadcom.com" <rjui@broadcom.com>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, "sbranden@broadcom.com" <sbranden@broadcom.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh@kernel.org" <robh@kernel.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>, dl-linux-imx <linux-imx@nxp.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alice Guo <alice.guo@nxp.com>, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

On Wed, Dec 04, 2019 at 04:20:41AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> platform_irq_count() is the more generic way (independent of
> device trees) to determine the count of available interrupts. So
> use this instead.
> 
> As platform_irq_count() might return an error code (which
> of_irq_count doesn't) some additional handling is necessary.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-and-Commit-Log-Provided-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

:-)
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
