From: Brian Norris <briannorris@chromium.org>
Subject: Re: [RFC PATCH v4 7/8] pwm: Add dummy pwmchip for orphan pwms
Date: Tue, 17 Oct 2017 10:04:29 -0700
Message-ID: <20171017170428.GB3408@google.com>
References: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
 <20171017101624.12506-8-jeffy.chen@rock-chips.com>
 <20171017124031.GA27983@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171017124031.GA27983@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, heiko@sntech.de, rjw@rjwysocki.net, dianders@chromium.org, tfiga@chromium.org, broonie@kernel.org, seanpaul@chromium.org, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

Hi,

On Tue, Oct 17, 2017 at 02:40:31PM +0200, Thierry Reding wrote:
> On Tue, Oct 17, 2017 at 06:16:23PM +0800, Jeffy Chen wrote:
> > When the pwm driver is unbound while the pwm is still requested, the
> > pwm core would not actually remove the pwmchip(return -EBUSY instead).
> > 
> > So it would hold some references to the invalid resources(e.g. pwmchip).
> > 
> > And the customer who requested the pwm would have those references too,
> > and may crash the kernel when trying to access them later.
> > 
> > Add a dummy pwmchip, and assign orphan pwms to it to avoid that.
> > 
> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> > ---
> > 
> > Changes in v4:
> > Fix compile warning.
> > 
> > Changes in v3:
> > Assign orphan pwms to dummy pwmchip instead of adding device link in the
> > customer driver.
> 
> What happened to this? Device links were specifically designed to avoid
> situations like these.

I think Jeffy came up with this as an odd response to my suggestion on
v2 that we could just handle the device links in the PWM core. I don't
fully understand why the complete change in direction...

BTW, since you seem to have an opinion about device links: is it
expected that all consumer drivers will make explicit calls to
device_link_add()? I thought this should be avoided, if possible (e.g.,
this can be handled in pwm_get()).

> A dummy PWM chip doesn't seem like the right solution to this.

Agreed.

Brian
