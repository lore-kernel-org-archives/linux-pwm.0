From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 20/20] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
Date: Fri, 10 Jun 2016 15:06:35 +0100
Message-ID: <20160610140635.GC1537@dell>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-21-lee.jones@linaro.org>
 <20160608205152.GA5511@rob-hp-laptop>
 <20160609114107.GB1388@dell>
 <20160610131855.GG27142@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160610131855.GG27142-EkSeR96xj6Pcmrwk2tT4+A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Fri, 10 Jun 2016, Thierry Reding wrote:

> On Thu, Jun 09, 2016 at 12:41:07PM +0100, Lee Jones wrote:
> > On Wed, 08 Jun 2016, Rob Herring wrote:
> >=20
> > > On Wed, Jun 08, 2016 at 10:21:35AM +0100, Lee Jones wrote:
> > > > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-dev=
s' to
> > > > be more inline with the naming conventions of the subsystem.  W=
here
> > > > we used to treat each line as a channel, the PWM convention is =
to
> > > > describe them as devices.
> > >=20
> > > That's all linux implementation details and you are breaking=20
> > > compatibility.
> >=20
> > Normally I'd agree with you, but I happen to know that a) this IP i=
s
> > currently unused and b) up until this point (and probably beyond), =
ST
> > always ship the DTB with the kernel, so there will be no breakage.
>=20
> Heh... I've long given up on trying to make that argument go anywhere=
=2E
> The general rule is that once we support a binding in a kernel releas=
e
> we have to support it indefinitely. If you really want to go ahead wi=
th
> this change (I don't think you should), you'd at least have to docume=
nt
> both properties and support st,pwm-num-chan in the driver for backwar=
ds
> compatibility.

I understand what the *general* rule is, but we have to remember why
this rule was put into place and apply some common sense.  In some
Enterprise user-cases where DTBs are written into ROM or where they
are difficult /impossible to update, I can completely understand the
requirement to support previous incarnations.  However in this, the
real world, DTBs are shipped with their corresponding kernels.  We
would lack a great deal of functionality if they weren't.  It is
therefor, foolhardy and inappropriate to stick to this rule just
'cos.

> > > > The second documentation adaption entails adding support for PW=
M
> > > > capture devices.  A new clock is required as well as an IRQ lin=
e.
> > > > We're also adding a new property similar to the one described
> > > > above, but for capture channels.  Typically, there will be less
> > > > capture channels than PWM-out, since all channels have the latt=
er
> > > > capability, but only some have capture support.
> > >=20
> > > Humm, sounds like all of this should be implied from compatible s=
trings.
> >=20
> > You mean have a bunch of of_machine_is_compatibles() scattered arou=
nd?
>=20
> I don't understand why you need this at all. Quite frankly I don't ev=
en
> know why st,pwm-num-devs exists. I probably missed it back at the tim=
e.
> Usually, like Rob suggests, this should be inferred from the compatib=
le
> string. One commonly used way to avoid scattering explicit checks for
> the compatible string is to add this information to the of_device_id
> table. See a bunch of existing drivers for reference.

Yes, I am aware of the strategy, and happy to oblige if this is your
suggestion.  I'll move all platform data into the driver and eradicate
the DT properties.

> Also, why make a separation of output vs. capture channels at this
> point? Could you not simply obtain the total number of PWM channels,
> preferably from SoC data associated with the compatible string, and
> check at ->capture() time whether or not the particular PWM supports
> this?
>=20
> As-is, you imply that you have n (output) + m (capture) channels, and
> that 0..n-1 are output and n..n+m-1 are capture channels. What if tha=
t
> no longer holds true, but 0 and 2 are the only ones that support
> capture?

We do?  What makes you think that?

> If you check for this at runtime you can avoid complicated DT parsing
> code, but still get the safety check which should be enough to encour=
age
> people to use the right channels in DT.

I'm pretty sure I can move all the data into the driver.  I did want
to avoid having lots of different compatible strings, but if that's
what you're suggesting, I can introduce one per supported platform.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
