From: Peter Griffin <peter.griffin@linaro.org>
Subject: Re: [STLinux Kernel] [[PATCH v2] 08/11] pwm: sti: Initialise PWM
 Capture device data
Date: Tue, 7 Jun 2016 16:30:27 +0100
Message-ID: <20160607153027.GB19771@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
 <1461320295-20414-9-git-send-email-lee.jones@linaro.org>
 <20160607082807.GC22744@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160607085814.GA18047@dell>
 <20160607104717.GA23326@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160607132907.GF18047@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35401 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755765AbcFGPae (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jun 2016 11:30:34 -0400
Received: by mail-wm0-f53.google.com with SMTP id v199so25067800wmv.0
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jun 2016 08:30:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160607132907.GF18047@dell>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, kernel@stlinux.com, thierry.reding@gmail.com, linus.walleij@linaro.org

Hi Lee,

On Tue, 07 Jun 2016, Lee Jones wrote:

> On Tue, 07 Jun 2016, Peter Griffin wrote:
> > On Tue, 07 Jun 2016, Lee Jones wrote:
> > > On Tue, 07 Jun 2016, Peter Griffin wrote:
> > > > On Fri, 22 Apr 2016, Lee Jones wrote:
> > > > 
> > > > > Each PWM Capture device is allocated a structure to hold its own
> > > > > state.  During a capture the device may be partaking in one of 3
> > > > > phases.  Initial (rising) phase change, a subsequent (falling)
> > > > > phase change indicating end of the duty-cycle phase and finally
> > > > > a final (rising) phase change indicating the end of the period.
> > > > > The timer value snapshot each event is held in a variable of the
> > > > > same name, and the phase number (0, 1, 2) is contained in the
> > > > > index variable.  Other device specific information, such as GPIO
> > > > > pin, the IRQ wait queue and locking is also contained in the
> > > > > structure.  This patch initialises this structure for each of
> > > > > the available devices.
> > > > > 
> > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > ---
> > > > >  drivers/pwm/pwm-sti.c | 45 ++++++++++++++++++++++++++++++++++++++-------
> > > > >  1 file changed, 38 insertions(+), 7 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > > > > index 78979d0..9d597bb 100644
> > > > > --- a/drivers/pwm/pwm-sti.c
> > > > > +++ b/drivers/pwm/pwm-sti.c
> > > 
> > > [...]
> > > 
> > > > > @@ -307,10 +318,15 @@ static int sti_pwm_probe_dt(struct sti_pwm_chip *pc)
> > > > >  	struct device_node *np = dev->of_node;
> > > > >  	struct sti_pwm_compat_data *cdata = pc->cdata;
> > > > >  	u32 num_devs;
> > > > > +	int ret;
> > > > >  
> > > > > -	of_property_read_u32(np, "st,pwm-num-devs", &num_devs);
> > > > > -	if (num_devs)
> > > > > -		cdata->num_devs = num_devs;
> > > > > +	ret = of_property_read_u32(np, "st,pwm-num-devs", &num_devs);
> > > > > +	if (!ret)
> > > > > +		cdata->pwm_num_devs = num_devs;
> > > > 
> > > > dt binding document documents this as st,pwm-num-chan currently.
> > > 
> > > It does, but see PATCH 2.
> > > 
> > > > Why do you need
> > > > this  binding anyway? Why can't you determine how many channels you have based on
> > > > the number of pinctrl groups you are given?
> > > 
> > > That sounds like a horrible idea; a) I'm not even sure if that's
> > > possible with the Pinctrl Consumer API and 
> > 
> > It would be possible I believe.
> 
> Okay, so I paid this idea some lip service despite thinking that it's
> crazy.

Thanks :-)

>  After looking at the API, I couldn't see anything suitable to
> achieve what you are suggesting, so I had a conversation with the
> Pinctrl maintainer who confirmed my thoughts.  In theory you could
> write a DT parser to hop around DT by phandle to find the information
> you're looking for, but it would be very complex and non-generic.  Way
> more trouble than it would ever be worth.

I thought it was possible to retrieve a group of pins by name. I think it
must have been the pinctrl_lookup_state() API I was thinking of.

> 
> > > b) even if is it physically
> > > possible, it sounds messy.  It's much better for code to be clear and
> > > simple.
> > 
> > I'm not sure encoding the same info in 2 places in the dt node is
> > clear or simple. Currently you can have a mis-match between the pwm_num_devs
> > / cpt_num_devs properties and the pinctrl configuration, and you can't detect
> > and warn / error if this happens, you just end up with something that doesn't
> > work.
> 
> I kinda see where you're coming from, but parsing the Pinctrl
> configuration to derive device information is not the way to go.
> Pinctrl's only aim is to simplify pin configuration (function,
> direction, etc), not to start describing how many channels a device
> has.

The number of useable channels the device has in this case is very closely linked with
the pin config though (see below).
> 
> By the way, what do you mean that there is a current mismatch?

It is possible to have a incoherent configuration whereby pwm_num_devs and
cpt_num_devs do not match up with the big list of pin groups you are providing
in pinctrl-0. Anyways it isn't really an issue if the pinctrl API doesn't exist to
allow you to do what I proposed.

> 
> > >  Code attempting to use clever inference techniques is usually
> > > pretty hard to understand and maintain.
> > 
> > Agreed, currently you are using a inference technique though, that updating
> > pwm_num_devs / cpt_num_devs properties also requires corresponding updates to
> > pinctrl-0 and maybe also the actual pin group definitions of
> > pinctrl_pwm1_chan*_default and friends.
> 
> We currently treat pin configuration and device properties separately,
> and rightly so in my opinion.  If you wish this to change, I'm sure
> the Pinctrl maintainer will accept sensible patches to add this
> functionality to the framework.  However today, this is not possible.
> 
> > Having pinctrl-names such as 
> > 
> > pwm-in-1
> > pwm-in-2
> > pwm-out-1 etc
> > 
> > You just iterate round obtaining pins by name, and create a pwm in/out channel for each
> > pin group you are given. No nasty inference, plus you don't encode the same
> > information in two places in the node :)
> 
> You can not obtain a pin by name currently, and I can't think of a
> sane reason why you would want to.  It might solve very small corner
> cases like this one, but in the real world, it's easier to solve them
> with a '*-num-*' type property like we do for everything else:
> 
>   git grep num -- arch/arm/boot/dts/

Looking through that grep, I can't see many examples where the '*-num-*' dt property
is directly linked to the number and amount of pins which should be configured.

The best example I can find is sd / emmc where <bus-width> describes the bus
width and the pinctrl-0 needs to correspond accordingly with the correct number
of pins. I guess this is similar.

> 
> > As a seperate point looking at the current pwm dt nodes in v4.7-rc1, the pinctrl-0 is being set in
> > stih407-family.dtsi, which is wrong, it should be set in the board specific file.
> 
> The idea of the stih407-family board file is to cut down on
> duplication.  To achieve this that file should contain everything
> which each the STiH410 and the STiH407 has in common.

It should contain everything which is common between these two SoC's which is
not board dependent. Things which vary due to board design need to live in
either stihxxx-b2120 if common between both SoC's and b2120 boards (like this will
be) or e.g. stih410-b2120.dts if it is more specific again to  a specific SoC and
board. Otherwise we will hit problems when adding new board variants in the
future.

>  If there are
> differences between the two platforms' PWM IP, then yes, I agree.  I
> can take a look at that.

> > Also I think the same applies to pwm_num_devs & cpt_num_devs dt properties.
> 
> Only if they differ.
> 
> > How many pwm channels you have available is determined by the pin muxing which depends
> > on the board layout, so they should be set in the board file along with the
> > pinctrl-0 not in stih407-family.dtsi.
> 
> I disagree with this point.  The number of channels the device
> supports and the amount of pins set-up on the board are orthogonal.

I guess this is the crux of the disagreement.

What happens in the pwm driver when you have more pwm channels declared in
pwm_num_devs & cpt_num_devs than physcially exist on the board?

Presumably at best you get garbage results for the pwm channels which
aren't connected to anything?

<snip>
> > 
> > > > For example at the moment I can't see any code in this series for handling the different
> > > > pinctrl groups which presumably are required to have this working.
> > > 
> > > To ease your curiosity, here is the patch which does that for the 407:
> > 
> > OK thanks, that makes more sense knowing that pwm-in and pwm-out are different
> > pins so you don't need to support changing the in/out config on the fly.
> > 
> > fyi without the dt doc update or the corresponding platform side dt changes,
> > it does makes it harder to review the pwm-st driver parts of the
> > series.
> 
> Very well.  In the next submission I will supply the entire set.
> 

ta, Regards,

Peter.
