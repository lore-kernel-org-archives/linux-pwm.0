From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [STLinux Kernel] [[PATCH v2] 08/11] pwm: sti: Initialise PWM
 Capture device data
Date: Tue, 7 Jun 2016 14:29:07 +0100
Message-ID: <20160607132907.GF18047@dell>
References: <1461320295-20414-1-git-send-email-lee.jones@linaro.org>
 <1461320295-20414-9-git-send-email-lee.jones@linaro.org>
 <20160607082807.GC22744@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160607085814.GA18047@dell>
 <20160607104717.GA23326@griffinp-ThinkPad-X1-Carbon-2nd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35335 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628AbcFGN2g (ORCPT
	<rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jun 2016 09:28:36 -0400
Received: by mail-wm0-f45.google.com with SMTP id v199so19642459wmv.0
        for <linux-pwm@vger.kernel.org>; Tue, 07 Jun 2016 06:28:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160607104717.GA23326@griffinp-ThinkPad-X1-Carbon-2nd>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, kernel@stlinux.com, thierry.reding@gmail.com, linus.walleij@linaro.org

On Tue, 07 Jun 2016, Peter Griffin wrote:
> On Tue, 07 Jun 2016, Lee Jones wrote:
> > On Tue, 07 Jun 2016, Peter Griffin wrote:
> > > On Fri, 22 Apr 2016, Lee Jones wrote:
> > >=20
> > > > Each PWM Capture device is allocated a structure to hold its ow=
n
> > > > state.  During a capture the device may be partaking in one of =
3
> > > > phases.  Initial (rising) phase change, a subsequent (falling)
> > > > phase change indicating end of the duty-cycle phase and finally
> > > > a final (rising) phase change indicating the end of the period.
> > > > The timer value snapshot each event is held in a variable of th=
e
> > > > same name, and the phase number (0, 1, 2) is contained in the
> > > > index variable.  Other device specific information, such as GPI=
O
> > > > pin, the IRQ wait queue and locking is also contained in the
> > > > structure.  This patch initialises this structure for each of
> > > > the available devices.
> > > >=20
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/pwm/pwm-sti.c | 45 +++++++++++++++++++++++++++++++++++=
+++-------
> > > >  1 file changed, 38 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
> > > > index 78979d0..9d597bb 100644
> > > > --- a/drivers/pwm/pwm-sti.c
> > > > +++ b/drivers/pwm/pwm-sti.c
> >=20
> > [...]
> >=20
> > > > @@ -307,10 +318,15 @@ static int sti_pwm_probe_dt(struct sti_pw=
m_chip *pc)
> > > >  	struct device_node *np =3D dev->of_node;
> > > >  	struct sti_pwm_compat_data *cdata =3D pc->cdata;
> > > >  	u32 num_devs;
> > > > +	int ret;
> > > > =20
> > > > -	of_property_read_u32(np, "st,pwm-num-devs", &num_devs);
> > > > -	if (num_devs)
> > > > -		cdata->num_devs =3D num_devs;
> > > > +	ret =3D of_property_read_u32(np, "st,pwm-num-devs", &num_devs=
);
> > > > +	if (!ret)
> > > > +		cdata->pwm_num_devs =3D num_devs;
> > >=20
> > > dt binding document documents this as st,pwm-num-chan currently.
> >=20
> > It does, but see PATCH 2.
> >=20
> > > Why do you need
> > > this  binding anyway? Why can't you determine how many channels y=
ou have based on
> > > the number of pinctrl groups you are given?
> >=20
> > That sounds like a horrible idea; a) I'm not even sure if that's
> > possible with the Pinctrl Consumer API and=20
>=20
> It would be possible I believe.

Okay, so I paid this idea some lip service despite thinking that it's
crazy.  After looking at the API, I couldn't see anything suitable to
achieve what you are suggesting, so I had a conversation with the
Pinctrl maintainer who confirmed my thoughts.  In theory you could
write a DT parser to hop around DT by phandle to find the information
you're looking for, but it would be very complex and non-generic.  Way
more trouble than it would ever be worth.

> > b) even if is it physically
> > possible, it sounds messy.  It's much better for code to be clear a=
nd
> > simple.
>=20
> I'm not sure encoding the same info in 2 places in the dt node is
> clear or simple. Currently you can have a mis-match between the pwm_n=
um_devs
> / cpt_num_devs properties and the pinctrl configuration, and you can'=
t detect
> and warn / error if this happens, you just end up with something that=
 doesn't
> work.

I kinda see where you're coming from, but parsing the Pinctrl
configuration to derive device information is not the way to go.
Pinctrl's only aim is to simplify pin configuration (function,
direction, etc), not to start describing how many channels a device
has.

By the way, what do you mean that there is a current mismatch?

> >  Code attempting to use clever inference techniques is usually
> > pretty hard to understand and maintain.
>=20
> Agreed, currently you are using a inference technique though, that up=
dating
> pwm_num_devs / cpt_num_devs properties also requires corresponding up=
dates to
> pinctrl-0 and maybe also the actual pin group definitions of
> pinctrl_pwm1_chan*_default and friends.

We currently treat pin configuration and device properties separately,
and rightly so in my opinion.  If you wish this to change, I'm sure
the Pinctrl maintainer will accept sensible patches to add this
functionality to the framework.  However today, this is not possible.

> Having pinctrl-names such as=20
>=20
> pwm-in-1
> pwm-in-2
> pwm-out-1 etc
>=20
> You just iterate round obtaining pins by name, and create a pwm in/ou=
t channel for each
> pin group you are given. No nasty inference, plus you don't encode th=
e same
> information in two places in the node :)

You can not obtain a pin by name currently, and I can't think of a
sane reason why you would want to.  It might solve very small corner
cases like this one, but in the real world, it's easier to solve them
with a '*-num-*' type property like we do for everything else:

  git grep num -- arch/arm/boot/dts/

> As a seperate point looking at the current pwm dt nodes in v4.7-rc1, =
the pinctrl-0 is being set in
> stih407-family.dtsi, which is wrong, it should be set in the board sp=
ecific file.

The idea of the stih407-family board file is to cut down on
duplication.  To achieve this that file should contain everything
which each the STiH410 and the STiH407 has in common.  If there are
differences between the two platforms' PWM IP, then yes, I agree.  I
can take a look at that.

> Also I think the same applies to pwm_num_devs & cpt_num_devs dt prope=
rties.

Only if they differ.

> How many pwm channels you have available is determined by the pin mux=
ing which depends
> on the board layout, so they should be set in the board file along wi=
th the
> pinctrl-0 not in stih407-family.dtsi.

I disagree with this point.  The number of channels the device
supports and the amount of pins set-up on the board are orthogonal.

> >  Besides, not every PWM channel is capable of
> > capture.
>=20
> OK, also currently the driver defaults to 0 if cpt_num_devs property =
is not supplied.
>=20
> So it would make sense to only obtain & enable capture clock and capt=
ure irq
> if cpt_num_devs >0?
>=20
> Currently the code will error if capture clock and capture irq is not=
 provided,
> and enable capture clock even if no capture channels are being used.

Good point.  Will fix.

> > > Also with this series I don't currently understand how the driver=
 is configured to be
> > > pwm-in or pwm-out. Can you explain how that decision is made?
> >=20
> > This patch-set does not concern itself with the platform specific
> > side.  I have a subsequent patch-set for that.  Perhaps it might be
> > nice to move the documentation update into this set though.
>=20
> It would definately be nice to update the dt documentation and code i=
n lockstep.
>=20
> Also IMHO the platform specific side should be included in this serie=
s,
> because, you are changing the st,pwm-num-chan binding which will brea=
k the currently
> merged pwm dt nodes. That change should ideally be changed as an atom=
ic commit, so
> we always have dt that matches the driver code.
>=20
> > > For example at the moment I can't see any code in this series for=
 handling the different
> > > pinctrl groups which presumably are required to have this working=
=2E
> >=20
> > To ease your curiosity, here is the patch which does that for the 4=
07:
>=20
> OK thanks, that makes more sense knowing that pwm-in and pwm-out are =
different
> pins so you don't need to support changing the in/out config on the f=
ly.
>=20
> fyi without the dt doc update or the corresponding platform side dt c=
hanges,
> it does makes it harder to review the pwm-st driver parts of the
> series.

Very well.  In the next submission I will supply the entire set.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
