From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH RESEND 2/2] gpio: mvebu: Allow to use non-default PWM
 counter
Date: Thu, 9 Aug 2018 17:43:05 +0200
Message-ID: <20180809154305.GE20006@lunn.ch>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-3-git-send-email-aditya@kobol.io>
 <20180806135257.GB6584@lunn.ch>
 <9d12abba-0be8-bce7-45d5-99659cbe0915@sorico.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9d12abba-0be8-bce7-45d5-99659cbe0915@sorico.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Aditya Prayoga <aditya@kobol.io>, linux-gpio@vger.kernel.org, Gregory CLEMENT <gregory.clement@bootlin.com>, Gauthier Provost <gauthier@kobol.io>, Alban Browaeys <alban.browaeys@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>, Ralph Sennhauser <ralph.sennhauser@gmail.com>
List-Id: linux-pwm@vger.kernel.org

> I'm not sure that the logic:
> 1. Default counter assigned to the bank
> 2. Unused counter that is assigned to other bank
> 3. Fallback to default counter
> is the best one.

Hi Richard

It it totally broken, as you point out. That is why i said it needs to
be limited to two PWMs.

> IMHO, I would either:
> - allow only 2 pwm and no more (but that's a pity)
> - allow lots of fans, but once 2 different speeds are set, return
>   EINVAL for another different speed (even if it's on another bank)

This second option also breaks the Linux PWM model.

What you should be thinking about is extending the Linux PWM model so
that one PWM can drive more than one pin.

     Andrew
