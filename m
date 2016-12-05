From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v3 3/7] PWM: add pwm-stm32 DT bindings
Date: Mon, 5 Dec 2016 11:50:06 +0100
Message-ID: <20161205105006.GA19891@ulmo.ba.sec>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-4-git-send-email-benjamin.gaignard@st.com>
 <20161205065350.GA18069@ulmo.ba.sec> <20161205083535.GB14004@dell>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9140923032541687274=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161205083535.GB14004@dell>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, lars@metafoo.de, alexandre.torgue@st.com, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, pmeerw@pmeerw.net, arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>, knaack.h@gmx.de, gerald.baeza@st.com, fabrice.gasnier@st.com, linus.walleij@linaro.org, jic23@kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-pwm@vger.kernel.org


--===============9140923032541687274==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 08:35:35AM +0000, Lee Jones wrote:
> On Mon, 05 Dec 2016, Thierry Reding wrote:
>=20
> > On Fri, Dec 02, 2016 at 11:17:18AM +0100, Benjamin Gaignard wrote:
> > > Define bindings for pwm-stm32
> > >=20
> > > version 2:
> > > - use parameters instead of compatible of handle the hardware configu=
ration
> > >=20
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > > ---
> > >  .../devicetree/bindings/pwm/pwm-stm32.txt          | 38 ++++++++++++=
++++++++++
> > >  1 file changed, 38 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.t=
xt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Do=
cumentation/devicetree/bindings/pwm/pwm-stm32.txt
> > > new file mode 100644
> > > index 0000000..575b9fb
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
> > > @@ -0,0 +1,38 @@
> > > +STMicroelectronics PWM driver bindings for STM32
> >=20
> > Technically this bindings describe devices, so "driver binding" is a
> > somewhat odd wording. Perhaps:
> >=20
> > 	STMicroelectronics STM32 General Purpose Timer PWM bindings
> >=20
> > ?
> >=20
> > > +
> > > +Must be a sub-node of STM32 general purpose timer driver
> > > +Parent node properties are describe in ../mfd/stm32-general-purpose-=
timer.txt
> >=20
> > Again, "driver parent node" is odd. Perhaps:
> >=20
> > 	Must be a sub-node of an STM32 General Purpose Timer device tree
> > 	node. See ../mfd/stm32-general-purpose-timer.txt for details about
> > 	the parent node.
> >=20
> > ?
> >=20
> > > +Required parameters:
> > > +- compatible:		Must be "st,stm32-pwm"
> > > +- pinctrl-names: 	Set to "default".
> > > +- pinctrl-0: 		List of phandles pointing to pin configuration nodes
> > > +			for PWM module.
> > > +			For Pinctrl properties, please refer to [1].
> >=20
> > Your indentation and capitalization are inconsistent. Also, please refer
> > to the pinctrl bindings by relative path and inline, rather than as a
> > footnote reference.
> >=20
> > > +
> > > +Optional parameters:
> > > +- st,breakinput:	Set if the hardware have break input capabilities
> > > +- st,breakinput-polarity: Set break input polarity. Default is 0
> > > +			 The value define the active polarity:
> > > +			  - 0 (active LOW)
> > > +			  - 1 (active HIGH)
> >=20
> > Could we fold these into a single property? If st,breakinput-polarity is
> > not present it could simply mean that there is no break input, and if it
> > is present you don't have to rely on a default.
> >=20
> > > +- st,pwm-num-chan:	Number of available PWM channels.  Default is 0.
> >=20
> > The pwm- prefix is rather redundant since the node is already named pwm.
> > Why not simply st,channels? Or simply channels, since it's not really
> > anything specific to this hardware.
> >=20
> > Come to think of it, might be worth having a discussion with our DT
> > gurus about what their stance is on using the # as prefix for numbers
> > (such as in #address-cells or #size-cells). This could be #channels to
> > mark it more explicitly as representing a count.
>=20
> Unfortunately that ship has sailed.
>=20
> st,pwm-num-chan already exists (with your blessing).  It's usually

I think I did at the time object, though very mildly. The property here
is somewhat different, though. For one this is a PWM specific node, so
the pwm- prefix is completely redundant. Also for pwm-sti where you had
introduced st,pwm-num-chan, the property denoted how many PWM channels
vs. capture channels (st,capture-num-chan) the device was supposed to
use. Here there are only one type of channels.

> suggested to reuse exiting properties when writing new bindings.

Given the above I think this case is different. Further my understanding
is that the desire to reuse existing properties is primarily for generic
properties. Vendor specific properties are always going to have to be
defined in the specific bindings, so it doesn't matter very much whether
they are reused or not.

Lastly, I think st,pwm-num-chan is not optimal, and while it isn't very
bad either, I do believe that when we see ways of improving things then
we should do so, regardless of whether existing ways to describe things
already exist. Especially if it comes at no additional cost.

All of that said, this is my opinion and if everybody thinks that the
st,pwm-num-chan is the better choice I'll merge it. Anyway, we'll need
the Acked-by from one of the device tree bindings maintainers and I'd
like to see at least an attempt at a discussion.

Thierry

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCAAGBQJYRUZbAAoJEN0jrNd/PrOh/goP/i++xv+o8PTJh6NkigyjSq8c
NHyW0Y7qziuJ/gI7zAOwD0w8FlwtubPZSqJdpaxIALS/VdTZYt3cVMtJBAIOp+I9
MU29K5aVVGgj/zw7b3IiYJiOEA70njlPC9+sDJ+IEr90qQbyTBRJEp8q6u8cCZLr
p8VWMTUawTkwDLw5o19KRdgzzdIBCwecTmmSovT74HlQFpOVCuBB6Z530iBOQ8vT
n3EegAcRA13oxcmPxy7QJSh+wNzvZmk0MHmWC+B0HjL0VmKJHioP1JtYZDFV51Or
drigZ9S4ZTMCSqL/H3u+x88/BQdKhAgjafRJ7SH+8NpDPe+M9+73cSDMLXfMxjB9
rFZ+uIWz3hV4PvJfZ+IO23Q/OyIxA78BiJjFel33HmIOep7hhRiGHYMqXSmxVr8U
A52fRFUkpnAqmsR2VGLKWeQLSEgC5WpqqtigXaYXnE4xViYXrR+kEUXduhSFqjeG
mCzYjYIeeI+i0KAVgmiNMuUG/C1yYXgZLea1ja1MK8IOGMuHwLESm1GMyTJaHDtA
yudg+5rY3VTomMyiOXcRvzLn1LmHOVsMynRQxWOyjYQw32kCncuyJu9Hb0XlM30T
ol2fpuuulb06lfn0uYVSxsr7uNtjR/bGvX56Tp0QeWfzKs4MLwVJW++4LKuyviRB
S+NgQ2e313obzxB/gGPq
=01Wm
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--


--===============9140923032541687274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9140923032541687274==--
