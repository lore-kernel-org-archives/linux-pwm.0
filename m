From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: [PATCHv6 0/3] pwm: imx: support output polarity inversion
Date: Mon, 12 Sep 2016 23:12:54 +0200
Message-ID: <20160912211254.GA4637@archie.localdomain>
References: <20141009151605.GA8818@ulmo.nvidia.com>
 <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
 <6c896634c4d6446df0388da2c0228232@agner.ch>
 <20160909091857.7a263220@ipc1.ka-ro>
 <20160912124553.aqgv7b4vsx4urogi@piout.net>
 <20160912140401.qkezay7sqqavsf4i@pengutronix.de>
 <074eed0df23199bc82f8d221690596d3@agner.ch>
 <20160912200021.fsnfdgnng4it354g@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160912200021.fsnfdgnng4it354g@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>
List-Id: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Sep 12, 2016 at 10:00:21PM +0200, Uwe Kleine-K=F6nig wrote:
> I want that the pwm driver disables its clock on pwm_config(mypwm, 0,
> someperiod) such that the consumer doesn't need to call
> pwm_disable(mypwm) to save power (assuming it's safe to do so, which
> only the pwm provider knows).

I am not sure if this is such a good idea, because there are use cases
where you want to keep the PWM driver enabled the whole time but still
be able to change the duty cycle to 0 for some time without adding
unnecessary delays when changing the duty cycle back to something else.

We have an application where we control fluid valves in a beer
dispensing system through PWMs and these valves are pulsed with
different PWM duty cycles for a short time. In-between the duty cycle
is also 0. For example: Start at 0%, 100ms 90%, 200ms 70%, 300ms 0%,
100ms 90%, and so on..
There it is critical that the change from and to 0 duty cycle is not
delayed by disabling and reenabling the clock.
The oscillator (if there is one) should be up and running, only the duty
cycle should be 0 for a short time.

This would not be possible anymore with your API change, right?

Regards,
Clemens
