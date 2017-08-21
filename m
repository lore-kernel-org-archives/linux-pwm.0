From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 0/2] extend PWM framework to support PWM dead-times
Date: Mon, 21 Aug 2017 13:25:42 +0200
Message-ID: <20170821112542.GA15750@ulmo>
References: <1494332153-14534-1-git-send-email-claudiu.beznea@microchip.com>
 <20170821082527.GQ18996@ulmo>
 <d7dafc19-5a35-78cf-cad2-6770e09bc03f@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:33084 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbdHULZq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Aug 2017 07:25:46 -0400
Content-Disposition: inline
In-Reply-To: <d7dafc19-5a35-78cf-cad2-6770e09bc03f@microchip.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: m18063 <Claudiu.Beznea@microchip.com>
Cc: corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com, alexandre.belloni@free-electrons.com, boris.brezillon@free-electrons.com, linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nicolas.ferre@microchip.com


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 21, 2017 at 01:23:08PM +0300, m18063 wrote:
> Hi Thierry,
>=20
> Thank you for your response. I added few comments below.
>=20
> Thank you,
> Claudiu
>=20
> On 21.08.2017 11:25, Thierry Reding wrote:
> > On Tue, May 09, 2017 at 03:15:51PM +0300, Claudiu Beznea wrote:
> >> Hi all,
> >>
> >> Please give feedback on these patches which extends the PWM
> >> framework in order to support multiple PWM signal types.
> >> Since I didn't receive any inputs on RFC series I'm resending it as
> >> normal patch series.
> >>
> >> The current patch series add the following PWM signal types:
> >> - PWM complementary signals
> >> - PWM push-pull signal
> >>
> >> Definition of PWM complementary mode:
> >> For a PWM controllers with more than one outputs per PWM channel,
> >> e.g. with 2 outputs per PWM channels, the PWM complementary signals
> >> have opposite levels, same duration and same starting times,
> >> as in the following diagram:
> >>
> >>         __    __    __    __
> >> PWMH __|  |__|  |__|  |__|  |__
> >>      __    __    __    __    __
> >> PWML   |__|  |__|  |__|  |__|
> >>        <--T-->
> >> Where T is the signal period.
> >>
> >> Definition of PWM push-pull mode:
> >> For PWM controllers with more than one outputs per PWM channel,
> >> e.g. with 2 outputs per PWM channel, the PWM push-pull signals
> >> have same levels, same duration and are delayed until the begining
> >> of the next period, as in the following diagram:
> >>
> >>         __          __
> >> PWMH __|  |________|  |________
> >>               __          __
> >> PWML ________|  |________|  |__
> >>        <--T-->
> >>
> >> Where T is the signal period.
> >>
> >> These output signals could be configured by setting PWM mode
> >> (a new input in sysfs has been added in order to support this
> >> operation).
> >>
> >> root@sama5d2-xplained:/sys/devices/platform/ahb/ahb:apb/f802c000.pwm/p=
wm/pwmchip0/pwm2# ls -l
> >> -r--r--r--    1 root     root          4096 Feb  9 10:54 capture
> >> -rw-r--r--    1 root     root          4096 Feb  9 10:54 duty_cycle
> >> -rw-r--r--    1 root     root          4096 Feb  9 10:54 enable
> >> -rw-r--r--    1 root     root          4096 Feb  9 10:54 mode
> >> -rw-r--r--    1 root     root          4096 Feb  9 10:54 period
> >> -rw-r--r--    1 root     root          4096 Feb  9 10:55 polarity
> >> drwxr-xr-x    2 root     root             0 Feb  9 10:54 power
> >> -rw-r--r--    1 root     root          4096 Feb  9 10:54 uevent
> >>
> >> The PWM push-pull mode could be usefull in applications like
> >> half bridge converters.
> >=20
> > Sorry for taking an absurdly long time to get back to you on this.
> >=20
> > One problem I see with this is that the PWM framework is built on the
> > assumption that we have a single output per PWM channel. This becomes
> > important when you start adding features such as this because now the
> > users have no way of determining whether or not the PWM they retrieve
> > will actually be able to do what they want.
> I was thinking that the framework is there to offer support in configuring
> the underlying hardware without taking into account how many outputs per
> PWM channels are actually present. It is true I only worked with Atmel/Mi=
crochip
> PWM controllers which for instance, SAMA5 SoC has a PWM controller
> with 2 outputs per PWM channel. Taking into account that the driver is
> already mainlined I though that the user is aware of what he is using
> (either a one output per PWM channel controller, or 2 outputs or
> more than 2) and about the underlying hardware support. I understand your
> position on this. I'm just explaining myself on the approach I've chose
> for this implementation.

So currently we assume that there will be (at least) one output per PWM
channel. However there are currently no drivers that actually use any
output other than the "primary" one.

That means, even if there are currently PWM controllers that support
multiple outputs per PWM channel, we have no code making assumptions
about it.

Before we can add code that makes any assumptions about the number of
outputs per PWM channel, we have to add facitilities for such code to
detect capabilities, so that they can deal with PWMs that don't match
what they need.

> > For example, let's say you have a half bridge converter driver in the
> > kernel and it does a pwm_get() to obtain a PWM to use. There's nothing
> > preventing it from using a simple one-output PWM and there's no way to
> > check that we're actually doing something wrong.
> I understand your position here. I've chose this approach taking into
> account that the user of the PWM will be aware of the capabilities
> of the underlying hardware because I worked on a controller which already
> has a mainlined driver and which has more than one output per PWM channel
> and I believe there are also other controllers with this kind of capabili=
ty
> and with already mainlined driver (e.g. reading the code of STM32 PWM dri=
ver
> I saw a bool type variable in driver specific data structure (struct stm3=
2_pwm):
> "bool have_complementary_output" which let me think that their controller
> also could support more than one output per PWM channel (I will also try
> to find the controller specific datasheet). At a first look I saw that al=
so
> TI ECAP PWM controller supports this (it is true that I am not aware of h=
ow
> it is initialized in kernel, I need to check the datasheet, if it is publ=
ic).

Yes, it's quite possible that many of the controllers we currently
support have this feature or not. But that's not really relevant. The
only important bit is that none of the users know about it. We don't
have the means to configure anything beyond just one output. So the only
guarantee you will get with the current framework is that there will be
one output signal per PWM channel.

> > I think any in-kernel API would have to be more fully-featured,
> > otherwise we're bound to run into problems. At the very least I think
> > we'd have to expose some sort of capabilities list.
> About the exposing of these capabilities would you prefer to have the
> supported PWM modes registered in driver probe as a new field mask
> in "struct pwm_chip". e.g.:
> struct pwm_chip {
>         struct device *dev;
>         struct list_head list;
>         const struct pwm_ops *ops;
>         int base;
>         unsigned int npwm;
> 	unsigned int pwm_modes_mask;	/* bitfield of supported signal types */
>=20
>         struct pwm_device *pwms;
>=20
>         struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
>                                         const struct of_phandle_args *arg=
s);
>         unsigned int of_pwm_n_cells;
> };
>=20
> And having in driver_probe() something like this:
> driver_data->pwm_chip.pwm_modes =3D PWM_COMPLEMENTARY_MODE | PWM_PUSH_PUL=
L_MODE;
> pwmchip_add(&driver_data->chip);
> Since the PWM push-pull mode imply more than one output per PWM channel. =
And
> validate the supported PWM modes when trying to configure one.
>=20
> Or registering, as a field in pwm_chip, how many outputs per channel are =
actually
> supported by the PWM controller and then validate the supported PWM mode =
based
> on this?
> e.g.:
> in "struct pwm_chip". e.g.:
> struct pwm_chip {
>         struct device *dev;
>         struct list_head list;
>         const struct pwm_ops *ops;
>         int base;
>         unsigned int npwm;
> 	unsigned int pwm_outputs;	/* Number of supported outputs per channel */
>=20
>         struct pwm_device *pwms;
>=20
>         struct pwm_device * (*of_xlate)(struct pwm_chip *pc,
>                                         const struct of_phandle_args *arg=
s);
>         unsigned int of_pwm_n_cells;
> };
>=20
> In driver_probe():
> //...
> driver_data->pwm_chip.pwm_outputs =3D 2; /* 2 outputs per PWM channel. */
> pwmchip_add(&driver_data->chip);

I think I'd prefer something more flexible. I also think this can't be
per-chip, but really has to be at the granularity of single PWM
channels. How about something like this:

	struct pwm_caps {
		...
	};

	int pwm_get_caps(struct pwm_device *pwm, struct pwm_caps *caps);

=46rom a high-level perspective that would give users an easy way to
obtain the capabilities of the PWM they're handed. Then we can start
filling in that structure.

	struct pwm_caps {
		unsigned long modes;
	};

	#define PWM_MODE_NORMAL (1 << 0)
	#define PWM_MODE_COMPLEMENTARY (1 << 1)
	#define PWM_MODE_PUSH_PULL (1 << 2)

	static inline bool pwm_caps_supports_mode(const struct pwm_caps *caps,
						  unsigned long mode)
	{
		return (caps->modes & mode) !=3D 0;
	}

and maybe something like this as a shortcut:

	static inline bool pwm_supports_mode(struct pwm_device *pwm,
					     unsigned long mode)
	{
		struct pwm_caps caps;
		int err;

		err =3D pwm_get_caps(pwm, &caps);
		if (err < 0)
			return false;

		return pwm_caps_supports_mode(&caps, mode);
	}

I think that gives us a lot of flexibility and easy extensibility for
other capabilities. The implementation of pwm_get_caps() should probably
call back into the driver.

But that would cause a lot of boilerplate for simple cases, and would be
a lot of work to convert all existing drivers up front. So I think we
can add helpers to solve the normal cases. Something along these lines
perhaps:

	struct pwm_chip {
		...

		int (*get_caps)(struct pwm_device *pwm, struct pwm_caps *caps);

		const struct pwm_caps *caps;
	};

	static int pwm_simple_get_caps(struct pwm_device *pwm, struct pwm_caps *ca=
ps)
	{
		if (!pwm || !caps || !pwm->chip->caps)
			return -EINVAL;

		*caps =3D *pwm->chip->caps;

		return 0;
	}

And then perhaps even do something like this:

	const struct pwm_caps pwm_default_caps =3D {
		.modes =3D PWM_MODE_NORMAL,
	};

Now we can either have a patch that sets pwm_default_caps and
pwm_simple_get_caps() for all existing drivers, or even easier add this
to the pwmchip_add_with_polarity() function:

	int pwmchip_add_with_polarity(struct pwm_chip *chip,
				      enum pwm_polarity polarity)
	{
		...

		if (!chip->get_caps && !chip->caps) {
			chip->get_caps =3D pwm_simple_get_caps;
			chip->caps =3D pwm_default_caps;
		}

		...
	}

That way, every driver, unless upgraded with a custom ->get_caps() would
get the defaults, which encode the current assumptions of the framework.

I think what we'd also want to do is make sure that every driver always
at least implement NORMAL mode and perhaps even fail to register those
that don't. Not sure we want to go that far, but those are the current
assumptions, so devices must be supporting it already anyway.

> > A possibly simpler approach might be to restrict this to the driver that
> > you need this for. It looks like you will be mainly using this via sysfs
> > and in that case you might be able to just extend what information is
> > exposed in sysfs for the particular PWM you're dealing with.
> By this you mean exporting the sysfs attributes only for my driver or pos=
sibly
> other drivers interested in this new feature? I may have another in kerne=
l driver
> which may try to use this feature.

If you've got another driver that will want to use this, I'm leaning
towards going with the fully featured approach. Ideally you would try to
implement both at once so we can get a better feeling about whether or
not the framework changes are adequate to cover at least the first two
cases, which is much more reassuring than just being able to cover a
single case.

One thing to consider is still that if you only use this from sysfs,
it'll be quite a lot of work to add in-kernel infrastructure when it's
never needed. There's still an advantage to do it anyway because it
allows us to abstract everything away properly from the start and avoid
fragmentation of the sysfs interface.

Thierry

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmawzQACgkQ3SOs138+
s6HCGQ//Sh4NyCtBGzGzS5atq/Zl0+IvvQu2MmQTQjJBqIC74Iv3uvlP3Yzs9I3w
p4jhwuTLVpY+RqJiTcXf3J357YppPiB7ZHlGL7UyMBcAK3lMs3fsQ/DfNfHyvSZn
NBF7kBrbsahgLin3EVEl67Mg/NfMMe2xC38XjYBM1VSZj/tY86sF4gP3eRj12xdd
ODbio7Jj//QV1AHEKk4PsUH3jxIEjPmgi/7Ja9XOhVYB16a3rCe/Lp8zgG92UpsI
UO8njUj6CEeYbwpEgWCeFlJ0fGFYqgde2Ba7QKDf8K0LNRWu1T/xnPO/MllOpNNH
iupZLORqnKtEUs4cu1+0obXBaGjQhbOuEL60lv4F6vviI2q5/pwmxibQacXqF+fR
mzyLIqf9ei42ZlDb7roYOzVS/oBhw/5HUaxbMTG0r5SqeKhrDBMYurdXzrnrohR7
psdKujXtPjMIiZ4JsgzJt9Qc6TLjEWgyh8KP/s9Nh++/v2Sg9rd2ii51u72uWR3L
awt7I0CJhhPp4aIYYcQnJ9Lw04ZtVWl/7t6vubuQktmpcJonv/QBqag5nZJDOclf
4DvFXITp02vD+G/8eaJyyHpaKM1b9B//xEvfbM/UcvQ5VgXaC+tWpwxGl61M1xNC
FqYRIXp/3oh4EBmki3Jczaxy3w3YgAvEg7jLgGhBbW1fP2XmMX0=
=VCLn
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
