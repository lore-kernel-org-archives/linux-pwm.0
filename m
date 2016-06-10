From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 20/20] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
Date: Fri, 10 Jun 2016 16:19:15 +0100
Message-ID: <20160610151915.GE7351@dell>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-21-lee.jones@linaro.org>
 <20160608205152.GA5511@rob-hp-laptop>
 <20160609114107.GB1388@dell>
 <20160610131855.GG27142@ulmo.ba.sec>
 <20160610140635.GC1537@dell>
 <20160610145323.GO27142@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160610145323.GO27142-EkSeR96xj6Pcmrwk2tT4+A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Fri, 10 Jun 2016, Thierry Reding wrote:
> On Fri, Jun 10, 2016 at 03:06:35PM +0100, Lee Jones wrote:
> > On Fri, 10 Jun 2016, Thierry Reding wrote:
> >=20
> > > On Thu, Jun 09, 2016 at 12:41:07PM +0100, Lee Jones wrote:
> > > > On Wed, 08 Jun 2016, Rob Herring wrote:
> > > >=20
> > > > > On Wed, Jun 08, 2016 at 10:21:35AM +0100, Lee Jones wrote:
> > > > > > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num=
-devs' to
> > > > > > be more inline with the naming conventions of the subsystem=
=2E  Where
> > > > > > we used to treat each line as a channel, the PWM convention=
 is to
> > > > > > describe them as devices.
> > > > >=20
> > > > > That's all linux implementation details and you are breaking=20
> > > > > compatibility.
> > > >=20
> > > > Normally I'd agree with you, but I happen to know that a) this =
IP is
> > > > currently unused and b) up until this point (and probably beyon=
d), ST
> > > > always ship the DTB with the kernel, so there will be no breaka=
ge.
> > >=20
> > > Heh... I've long given up on trying to make that argument go anyw=
here.
> > > The general rule is that once we support a binding in a kernel re=
lease
> > > we have to support it indefinitely. If you really want to go ahea=
d with
> > > this change (I don't think you should), you'd at least have to do=
cument
> > > both properties and support st,pwm-num-chan in the driver for bac=
kwards
> > > compatibility.
> >=20
> > I understand what the *general* rule is, but we have to remember wh=
y
> > this rule was put into place and apply some common sense.  In some
> > Enterprise user-cases where DTBs are written into ROM or where they
> > are difficult /impossible to update, I can completely understand th=
e
> > requirement to support previous incarnations.  However in this, the
> > real world, DTBs are shipped with their corresponding kernels.  We
> > would lack a great deal of functionality if they weren't.  It is
> > therefor, foolhardy and inappropriate to stick to this rule just
> > 'cos.
>=20
> I used to advocate the very same point of view a couple of years ago =
but
> was repeatedly told that it's irrelevant, and everybody was to be hel=
d
> to the same standards, irrespective of how easy it is to update the D=
TB
> in lockstep with the kernel.
>=20
> Part of me still wishes that the rules were a little less strict, but=
 a
> decision was made on this years ago, so I'm just repeating this here =
in
> an attempt to save you from wasting your time arguing.
>=20
> Then again, there have been occasions where decisions were undone, so
> you might have better luck nowadays if you're willing to take this to
> the DT bindings and ARM-SoC maintainers.
>=20
> Bottom line: NAK on the backwards-incompatible DT binding change from=
 me
> based on earlier decisions made on this topic. But I may be swayed if
> everyone else thinks ABI stability is no longer something we consider
> important for DT.

I've seen properties come and go.  Both using the deprecation process
and otherwise.  By NAKing these types of changes, you're just
exacerbating the situation.  If you know it's the right
(non-foolhardy) thing to do, just do it.

Although, I feel the point is moot for this particular driver now,
what with all of the pdata being moved into the driver.

> > > > > > The second documentation adaption entails adding support fo=
r PWM
> > > > > > capture devices.  A new clock is required as well as an IRQ=
 line.
> > > > > > We're also adding a new property similar to the one describ=
ed
> > > > > > above, but for capture channels.  Typically, there will be =
less
> > > > > > capture channels than PWM-out, since all channels have the =
latter
> > > > > > capability, but only some have capture support.
> > > > >=20
> > > > > Humm, sounds like all of this should be implied from compatib=
le strings.
> > > >=20
> > > > You mean have a bunch of of_machine_is_compatibles() scattered =
around?
> > >=20
> > > I don't understand why you need this at all. Quite frankly I don'=
t even
> > > know why st,pwm-num-devs exists. I probably missed it back at the=
 time.
> > > Usually, like Rob suggests, this should be inferred from the comp=
atible
> > > string. One commonly used way to avoid scattering explicit checks=
 for
> > > the compatible string is to add this information to the of_device=
_id
> > > table. See a bunch of existing drivers for reference.
> >=20
> > Yes, I am aware of the strategy, and happy to oblige if this is you=
r
> > suggestion.  I'll move all platform data into the driver and eradic=
ate
> > the DT properties.
>=20
> Great!
>=20
> > > Also, why make a separation of output vs. capture channels at thi=
s
> > > point? Could you not simply obtain the total number of PWM channe=
ls,
> > > preferably from SoC data associated with the compatible string, a=
nd
> > > check at ->capture() time whether or not the particular PWM suppo=
rts
> > > this?
> > >=20
> > > As-is, you imply that you have n (output) + m (capture) channels,=
 and
> > > that 0..n-1 are output and n..n+m-1 are capture channels. What if=
 that
> > > no longer holds true, but 0 and 2 are the only ones that support
> > > capture?
> >=20
> > We do?  What makes you think that?
>=20
> Because there's nothing saying otherwise? The DT binding is completel=
y
> silent on the matter, and the above is the most logical interpretatio=
n
> that I came up with.

But you made it up. :)

It's not documented because it's irrelevant how channels are numbered.

Actually, looking at the docs, the IP doesn't change from one channel
to another, so in theory they all support capture.  The only issue is
whether they are plumbed in or not.  I'll take a  closer look at all
the platforms we support when I move the pdata.

> Looking at the driver it seems like it's actually the other way aroun=
d
> and you have the first m channels that support both output and captur=
e
> functionality. But the issue remains that this isn't documented in th=
e
> DT binding documentation. And the current properties are also not ver=
y
> flexible because they allow for only a single scheme of assigning the
> capability.
>=20
> If you move all of that knowledge into the driver, things become a lo=
t
> easier, in my opinion.

Sure.

> > > If you check for this at runtime you can avoid complicated DT par=
sing
> > > code, but still get the safety check which should be enough to en=
courage
> > > people to use the right channels in DT.
> >=20
> > I'm pretty sure I can move all the data into the driver.  I did wan=
t
> > to avoid having lots of different compatible strings, but if that's
> > what you're suggesting, I can introduce one per supported platform.
>=20
> That sounds like the simplest solution to me.

Okay.

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
