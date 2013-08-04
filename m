Return-Path: <morbidrsa@gmail.com>
Return-Path: <morbidrsa@gmail.com>
Date: Sun, 4 Aug 2013 20:51:37 +0200
From: Johannes Thumshirn <morbidrsa@gmail.com>
Subject: Re: Determining wich PWM to use
Message-ID: <20130804185137.GA10948@sauron>
References: <20130727101824.GA11956@sauron.fritz.box>
 <20130804110346.GA20305@manwe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130804110346.GA20305@manwe>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org

On Sun, Aug 04, 2013 at 01:03:47PM +0200, Thierry Reding wrote:
> On Sat, Jul 27, 2013 at 12:18:24PM +0200, Johannes Thumshirn wrote:
> > Hi list,
> > 
> > I'm currently working on a pwm driver for the BCM2853 (the SoC used on the
> > RaspberryPi). It has two PWM modules, so my question is, how do I determine
> > which PWM to use in the .enable, .disable and .configure functions?
> 
> It depends on what you mean by "two PWM modules". Does it have one
> controller with two PWM outputs or does it have two controllers with one
> or more outputs?
> 
> If you have one controller with multiple outputs, which seems to be the
> case looking at the driver, then the struct pwm_device's .hwpwm field
> contains the per-chip index of the PWM channel.
> 
> > If someone wants to have have a look at the preliminary code (far from being
> > submittable and only compile tested) it can be found here:
> > 
> > https://github.com/morbidrsa/linux/blob/rpi-pwm/drivers/pwm/pwm-bcm2835.c
> 
> From a quick glance that looks pretty good already. Feel free to send it
> to the mailing list for review anytime.
> 
> > 2nd short question, is it considered good practice to encapsulate registers in
> > structs? I've seen this a lot on powerpc code.
> 
> It's not very common. I certainly prefer the standard way of using
> writel(value, base + offset) and readl(base + offset), or a variation of
> that using driver-specific accessors such as you've done in the above-
> mentioned code.
> 
> Thierry


Thanks. I'll try to get the code submittable till the end of the moth.

Johannes
