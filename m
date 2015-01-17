From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 3/7] gpio: mvebu: Add limited PWM support
Date: Sat, 17 Jan 2015 21:04:16 +0100
Message-ID: <20150117200416.GB19604@lunn.ch>
References: <1420846493-31647-1-git-send-email-andrew@lunn.ch>
 <1420846493-31647-4-git-send-email-andrew@lunn.ch>
 <CACRpkdZe2BMtTPU6wkd+gk5mttz3GdL_zYCTPQOaubwRAHbDgg@mail.gmail.com>
 <20150113024256.GH19533@lunn.ch>
 <CACRpkda_guCTyivDB5z8jisxYvnsE-1vrvt+N_k1Kp_f+nhQFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkda_guCTyivDB5z8jisxYvnsE-1vrvt+N_k1Kp_f+nhQFg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
Cc: Thierry Reding <thierry.reding@gmail.com>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Imre Kaloz <kaloz@openwrt.org>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pwm@vger.kernel.org

> I think it's better if we either go with the first solution of a combined
> GPIO+PWM node (it's also elegant in a way, and perfectly
> OK with device tree I think) but I want the PWM maintainer to
> say if it's OK to have a PWM driver inside a GPIO driver.

Hi Thierry

Please could you comment on this. I would like to get moving forward
with getting these patches accepted.

Thanks
	Andrew
