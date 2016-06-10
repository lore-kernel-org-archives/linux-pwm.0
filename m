From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 20/20] dt-bindings: pwm: sti: Update DT bindings with
 recent changes
Date: Fri, 10 Jun 2016 15:18:55 +0200
Message-ID: <20160610131855.GG27142@ulmo.ba.sec>
References: <20160608092135.21184-1-lee.jones@linaro.org>
 <20160608092135.21184-21-lee.jones@linaro.org>
 <20160608205152.GA5511@rob-hp-laptop>
 <20160609114107.GB1388@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160609114107.GB1388@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, maxime.coquelin@st.com, patrice.chotard@st.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 09, 2016 at 12:41:07PM +0100, Lee Jones wrote:
> On Wed, 08 Jun 2016, Rob Herring wrote:
>=20
> > On Wed, Jun 08, 2016 at 10:21:35AM +0100, Lee Jones wrote:
> > > We're renaming the 'st,pwm-num-chan' binding to 'st,pwm-num-devs' to
> > > be more inline with the naming conventions of the subsystem.  Where
> > > we used to treat each line as a channel, the PWM convention is to
> > > describe them as devices.
> >=20
> > That's all linux implementation details and you are breaking=20
> > compatibility.
>=20
> Normally I'd agree with you, but I happen to know that a) this IP is
> currently unused and b) up until this point (and probably beyond), ST
> always ship the DTB with the kernel, so there will be no breakage.

Heh... I've long given up on trying to make that argument go anywhere.
The general rule is that once we support a binding in a kernel release
we have to support it indefinitely. If you really want to go ahead with
this change (I don't think you should), you'd at least have to document
both properties and support st,pwm-num-chan in the driver for backwards
compatibility.

> > > The second documentation adaption entails adding support for PWM
> > > capture devices.  A new clock is required as well as an IRQ line.
> > > We're also adding a new property similar to the one described
> > > above, but for capture channels.  Typically, there will be less
> > > capture channels than PWM-out, since all channels have the latter
> > > capability, but only some have capture support.
> >=20
> > Humm, sounds like all of this should be implied from compatible strings.
>=20
> You mean have a bunch of of_machine_is_compatibles() scattered around?

I don't understand why you need this at all. Quite frankly I don't even
know why st,pwm-num-devs exists. I probably missed it back at the time.
Usually, like Rob suggests, this should be inferred from the compatible
string. One commonly used way to avoid scattering explicit checks for
the compatible string is to add this information to the of_device_id
table. See a bunch of existing drivers for reference.

Also, why make a separation of output vs. capture channels at this
point? Could you not simply obtain the total number of PWM channels,
preferably from SoC data associated with the compatible string, and
check at ->capture() time whether or not the particular PWM supports
this?

As-is, you imply that you have n (output) + m (capture) channels, and
that 0..n-1 are output and n..n+m-1 are capture channels. What if that
no longer holds true, but 0 and 2 are the only ones that support
capture?

If you check for this at runtime you can avoid complicated DT parsing
code, but still get the safety check which should be enough to encourage
people to use the right channels in DT.

Thierry

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXWr4/AAoJEN0jrNd/PrOhmJ0P/A9UE4RtPDkvqerNqjTY/IEv
4LPm2o1CaGzlEMUp5WVEIwKw1B3cTkXjmicZSOA1znOkgTqV1w8wzc1mBOKjQqP1
7yR3o/vdz8aS+23W3cCTjHkw7qJyGGAtvaiNZ81EoAQiwZWVe0Nkp4NoOWBfPBiQ
u2ImZ5iwXNMCP3g9s+VE3pFqTigNo4cAk1XRXMwF8WPvMu8n72GoybCNnP3geeiL
w9s3ESkxxhYcphsy2i7j6pDxRMM8abvQWIwDFE/mTqgMJ1hUcl5JtPSGgPOZPdqg
bHBXNCPDIbRCPkYnJp+4JKvnbi8N8ge19XfLWAZV50vvFmajcBFKBqS4kUoY/gQO
7yui2V9OhQwfqiIXKO+LEbgfcBvOGdimdhwFz7oCTTgKBwSdOp4HJSNN/51zY6pV
GdWMgGNWQtxDFZyKBCCMotZ0/dgj9ru/32c5+saHnSYNiGd8zBguZoeAC90deVuG
zoPIZxdvvnee/3cEq6XBAJ1mf/TXacTpd+17Bcqs+y+1bbV3EhzfgElUB+6OHwrc
Zc6ZpFR4gvBIsROHdHyvYj4N/fBmSNFsO6mljj6uaiCu0EuZxPpk4WkLtjjGpjR9
xo/KMmQ16pydsfSr/p7yaWJ6ZOO5z4OxTnaD1suPtXJnbLiHiJSuFRqm+QBbHrfu
AbJwyc41wJCK51N1SzQT
=0VUw
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
