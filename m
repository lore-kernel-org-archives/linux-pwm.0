From: Brian Norris <briannorris@chromium.org>
Subject: Re: [RFC PATCH v4 7/8] pwm: Add dummy pwmchip for orphan pwms
Date: Tue, 17 Oct 2017 11:53:01 -0700
Message-ID: <20171017185259.GA41348@google.com>
References: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
 <20171017101624.12506-8-jeffy.chen@rock-chips.com>
 <20171017124031.GA27983@ulmo>
 <20171017170428.GB3408@google.com>
 <CAKdAkRRm9aK3KmPTqtD0d1dENyAq7aXrSEjKXZQMXuJin2hoUA@mail.gmail.com>
 <20171017184603.yluoukqq6hj2cgcb@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171017184603.yluoukqq6hj2cgcb@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jeffy Chen <jeffy.chen@rock-chips.com>, lkml <linux-kernel@vger.kernel.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>, tfiga@chromium.org, seanpaul@chromium.org, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

On Tue, Oct 17, 2017 at 07:46:03PM +0100, Mark Brown wrote:
> On Tue, Oct 17, 2017 at 11:24:24AM -0700, Dmitry Torokhov wrote:
> > On Tue, Oct 17, 2017 at 10:04 AM, Brian Norris <briannorris@chromium.org> wrote:
> 
> > > BTW, since you seem to have an opinion about device links: is it
> > > expected that all consumer drivers will make explicit calls to
> > > device_link_add()? I thought this should be avoided, if possible (e.g.,
> > > this can be handled in pwm_get()).
> 
> > Ideally we would not have this in core kernel API (pwm_get, gpiod_get,
> > regulator_get, etc) but retrieve it form the firmware (device tree,
> > ACPI) and use this data not only on suspend/resume but for probing as
> 
> Right, the major initial push here was for ordering of probes so doing
> it in subsystems or drivers is too late.
> 
> > well. *How exactly* can we do that is still not clear though, so maybe
> > we could plug the biggest holes by actually adding device links calls
> > to the main devm_<object>_get() users...
> 
> I would expect we can get a long way in the DT by doing a pass over the
> tree and adding links between device nodes in cases where phandle
> references exist.  There is a potential issue with circular links which
> I'm just going to handwave away right now but I'd expect that to help
> otherwise.

But I didn't think FDTs encoded type info. So you don't really know
whether a phandle is a phandle -- it's just an int (which happens to
have a corresponding property in some other node). Are we trusting our
DT bindings well enough to say that, for example, we know that in any
given device node, a property like 'pwms' must be a phandle to a PWM
provider? OK, maybe 'pwms' is a bad example (it's unlikely to get
reused, and it has a companion '#pwm-cells' property), but grepping the
DT bindings directory shows a ton of one-off properties that contain
phandles.

Brian
