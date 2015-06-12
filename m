From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCHv2 2/2] PWM: atmel: fix incorrect CDTY value after
 disabling
Date: Fri, 12 Jun 2015 11:17:48 +0200
Message-ID: <20150612091747.GB19400@ulmo.nvidia.com>
References: <1432559996-4415-2-git-send-email-alexandre.belloni@free-electrons.com>
 <1432570309-17819-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432570309-17819-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Mon, May 25, 2015 at 06:11:49PM +0200, Alexandre Belloni wrote:
> pwm-leds calls .config() and .disable() in a row. This exhibits that it may
> happen that the channel gets disabled before CDTY has been updated with CUPD.
> The issue gets quite worse with long periods.
> So, ensure that at least one period has past before disabling the channel by
> polling ISR.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
> I had the previous patch tested on a multicolor LED and unfortunately, the delay
> is not nice in that case. I wanted to avoid a mutex.
> This version uses a variable to store the state of the update of the pwm. This
> is reset everytime is gets a new configuration and updated when it is disabled
> or another pwm is configured.
> When disabling a multicolor LED, we only wait for the first pwm to update then
> we remember that we already seen the other one having their period expire and it
> looks much better.
> 
>  drivers/pwm/pwm-atmel.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Applied, thanks.

Thierry
