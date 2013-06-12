Return-Path: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2013 14:46:27 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pwm: Fill in missing .owner fields
Message-ID: <20130612214627.GA486@kroah.com>
References: <1371036553-32263-1-git-send-email-thierry.reding@gmail.com>
 <CAK9yfHyUT7KUkY3g2WJ7XiisLL5mvJuenv=UEK_9OqwfF7s4Zg@mail.gmail.com>
 <20130612195917.GA31835@mithrandir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130612195917.GA31835@mithrandir>
List-ID: <linux-pwm.vger.kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 12, 2013 at 09:59:18PM +0200, Thierry Reding wrote:
> On Wed, Jun 12, 2013 at 05:05:18PM +0530, Sachin Kamat wrote:
> > Hi Thierry,
> > 
> > On 12 June 2013 16:59, Thierry Reding <thierry.reding@gmail.com> wrote:
> > > Some drivers don't set the .owner fields of the struct device_driver or
> > > struct pwm_ops, which causes the module usage count to become wrong.
> > 
> > 
> > Recently a patch [1] was added to solve this issue of missing .owner
> > fileds in struct platform_driver.
> 
> Yes I saw that, but thought it might be good to initialize them anyway.
> Especially since a couple of the drivers are I2C and I believe there's
> no similar patch for those. It shouldn't be difficult to come up with
> the corresponding patch, though.
> 
> I wonder if it'd make sense to remove all the explicit assignments of
> .owner = THIS_MODULE in platform drivers once the patch you mentioned
> has been merged. Cc'ing Greg to find out what he thinks about it.

Sure, they can be removed, but it's not really a big deal if they
aren't.

greg k-h
