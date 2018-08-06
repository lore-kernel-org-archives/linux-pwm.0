From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH RESEND 2/2] gpio: mvebu: Allow to use non-default PWM
 counter
Date: Mon, 6 Aug 2018 15:52:57 +0200
Message-ID: <20180806135257.GB6584@lunn.ch>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
 <1533522556-55055-3-git-send-email-aditya@kobol.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533522556-55055-3-git-send-email-aditya@kobol.io>
Sender: linux-kernel-owner@vger.kernel.org
To: Aditya Prayoga <aditya@kobol.io>
Cc: linux-gpio@vger.kernel.org, Richard Genoud <richard.genoud@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Gauthier Provost <gauthier@kobol.io>, Alban Browaeys <alban.browaeys@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>, Ralph Sennhauser <ralph.sennhauser@gmail.com>
List-Id: linux-pwm@vger.kernel.org

On Mon, Aug 06, 2018 at 10:29:16AM +0800, Aditya Prayoga wrote:
> On multiple PWM lines, if the other PWM counter is unused, allocate it
> to next PWM request. The priority would be:
> 1. Default counter assigned to the bank
> 2. Unused counter that is assigned to other bank
> 3. Fallback to default counter
> 
> For example on second bank there are three PWM request, first one would
> use default counter (counter B), second one would try to use counter A,
> and the third one would use counter B.

Hi Aditya

There are only two PWM counters for all the GPIO lines. So you cannot
support 3 PWM requests. You have to enforce a maximum of two PWMs.

When i implemented this PWM code, i only needed one PWM. So it took
the easy option. GPIO bank 0 uses counter A, GPIO bank1 uses counter
B. For the hardware you have, this is not sufficient, so you need to
generalise this. Any PWM can use any counter, whatever is available
when the PWM is requested.

Rather than have a linked list of PWM, i think it would be better to
have a static array of two mvebu_pwm structures. Index 0 uses counter
A, index 1 uses counter B. You can then keep with the concept of
pwm->pgiod != NULL means the counter is in use. The request() call can
then find an unused PWM, set pwm->gpiod, and point mvchip->mvpwm to
one of the two static instances.

    Andrew
