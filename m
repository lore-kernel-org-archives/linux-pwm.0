Return-Path: <sha@pengutronix.de>
Date: Mon, 30 Sep 2013 10:20:58 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCHv5 0/4] Add Freescale FTM PWM driver.
Message-ID: <20130930082058.GB30088@pengutronix.de>
References: <1380521611-2764-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380521611-2764-1-git-send-email-Li.Xiubo@freescale.com>
List-ID: <linux-pwm.vger.kernel.org>
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: r65073@freescale.com, thierry.reding@gmail.com, swarren@wwwdotorg.org, t.figa@samsung.com, grant.likely@linaro.org, linux@arm.linux.org.uk, rob@landley.net, ian.campbell@citrix.com, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org

On Mon, Sep 30, 2013 at 02:13:27PM +0800, Xiubo Li wrote:
> Hello,
> 
> This patch series is the Freescale FTM PWM implementation. And there are 8 channels most supported by the FTM PWM. This implementation is only compatible with device tree definition.
> 
> This patch series is based on linux-next and has been tested on Vybrid VF610 Tower board using device tree.

Looks good to me now. Thanks for fixing.

For the series:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
