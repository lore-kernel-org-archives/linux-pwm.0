Return-Path: <thierry.reding@gmail.com>
Date: Mon, 12 Aug 2013 09:21:58 +0200
From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] pwm: renesas-tpu: Add DT support
Message-ID: <20130812072157.GA17056@ulmo>
References: <1374791261-9850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1943187.cb9fxEDeXJ@avalon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <1943187.cb9fxEDeXJ@avalon>
List-ID: <linux-pwm.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2013 at 12:44:42PM +0200, Laurent Pinchart wrote:
> Hi Thierry,
>=20
> I'd like to get this patch in v3.12, could you please take it in your tre=
e ?

I'm Cc'ing the device tree bindings maintainers. Given that this uses
only the standard PWM bindings in the first place I suppose it would be
okay to take this in, but I'd like to run it past them to make sure.

> On Friday 26 July 2013 00:27:41 Laurent Pinchart wrote:
> > Specify DT bindings for the TPU PWM controller and add OF support to the
> > driver.
> >=20
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.=
com>
> > ---
> >  .../devicetree/bindings/pwm/renesas,tpu-pwm.txt    | 28 +++++++++++++++
> >  drivers/pwm/pwm-renesas-tpu.c                      | 41 ++++++++++++++=
+----
> >  2 files changed, 62 insertions(+), 7 deletions(-)
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
> >=20
> > This patch depends on the "[PATCH v2 0/4] Add PWM polarity flag macro f=
or
> > DT" series that is scheduled for merge in the PWM tree, and should thus=
 go
> > in via the same tree.
> >=20
> > The code has been tested on an Armadillo800EVA with additional platform
> > patches that I'm going to submit next.
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
> > b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt new file mo=
de
> > 100644
> > index 0000000..b067e84
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
> > @@ -0,0 +1,28 @@
> > +* Renesas R-Car Timer Pulse Unit PWM Controller
> > +
> > +Required Properties:
> > +
> > +  - compatible: should be one of the following.
> > +    - "renesas,tpu-r8a73a4": for R8A77A4 (R-Mobile APE6) compatible PWM
> > controller. +    - "renesas,tpu-r8a7740": for R8A7740 (R-Mobile A1)
> > compatible PWM controller. +    - "renesas,tpu-r8a7790": for R8A7790 (R=
-Car
> > H2) compatible PWM controller. +    - "renesas,tpu-sh7372": for SH7372
> > (SH-Mobile AP4) compatible PWM controller. +    - "renesas,tpu": for
> > generic R-Car TPU PWM controller.
> > +
> > +  - reg: Base address and length of each memory resource used by the P=
WM
> > +    controller hardware module.
> > +
> > +  - #pwm-cells: should be 3. See pwm.txt in this directory for a
> > description of +    the cells format. The only third cell flag supporte=
d by
> > this binding is +    PWM_POLARITY_INVERTED.
> > +
> > +Please refer to pwm.txt in this directory for details of the common PWM
> > bindings +used by client devices.
> > +
> > +Example: R8A7740 (R-Car A1) TPU controller node
> > +
> > +	tpu: pwm@e6600000 {
> > +		compatible =3D "renesas,tpu-r8a7740", "renesas,tpu";
> > +		reg =3D <0xe6600000 0x100>;
> > +		#pwm-cells =3D <3>;
> > +	};
> > diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tp=
u.c
> > index 2600892..3eeffff 100644
> > --- a/drivers/pwm/pwm-renesas-tpu.c
> > +++ b/drivers/pwm/pwm-renesas-tpu.c
> > @@ -20,6 +20,7 @@
> >  #include <linux/ioport.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/of.h>
> >  #include <linux/platform_data/pwm-renesas-tpu.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_runtime.h>
> > @@ -86,7 +87,7 @@ struct tpu_pwm_device {
> >=20
> >  struct tpu_device {
> >  	struct platform_device *pdev;
> > -	struct tpu_pwm_platform_data *pdata;
> > +	enum pwm_polarity polarities[TPU_CHANNEL_MAX];
> >  	struct pwm_chip chip;
> >  	spinlock_t lock;
> >=20
> > @@ -228,8 +229,7 @@ static int tpu_pwm_request(struct pwm_chip *chip, s=
truct
> > pwm_device *_pwm)
> >=20
> >  	pwm->tpu =3D tpu;
> >  	pwm->channel =3D _pwm->hwpwm;
> > -	pwm->polarity =3D tpu->pdata ? tpu->pdata->channels[pwm->channel].pol=
arity
> > -		      : PWM_POLARITY_NORMAL;
> > +	pwm->polarity =3D tpu->polarities[pwm->channel];
> >  	pwm->prescaler =3D 0;
> >  	pwm->period =3D 0;
> >  	pwm->duty =3D 0;
> > @@ -388,6 +388,16 @@ static const struct pwm_ops tpu_pwm_ops =3D {
> >   * Probe and remove
> >   */
> >=20
> > +static void tpu_parse_pdata(struct tpu_device *tpu)
> > +{
> > +	struct tpu_pwm_platform_data *pdata =3D tpu->pdev->dev.platform_data;
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(tpu->polarities); ++i)
> > +		tpu->polarities[i] =3D pdata ? pdata->channels[i].polarity
> > +				   : PWM_POLARITY_NORMAL;
> > +}
> > +
> >  static int tpu_probe(struct platform_device *pdev)
> >  {
> >  	struct tpu_device *tpu;
> > @@ -400,7 +410,11 @@ static int tpu_probe(struct platform_device *pdev)
> >  		return -ENOMEM;
> >  	}
> >=20
> > -	tpu->pdata =3D pdev->dev.platform_data;
> > +	spin_lock_init(&tpu->lock);
> > +	tpu->pdev =3D pdev;
> > +
> > +	/* Initialize device configuration from platform data. */
> > +	tpu_parse_pdata(tpu);
> >=20
> >  	/* Map memory, get clock and pin control. */
> >  	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > @@ -422,11 +436,10 @@ static int tpu_probe(struct platform_device *pdev)
> >  	/* Initialize and register the device. */
> >  	platform_set_drvdata(pdev, tpu);
> >=20
> > -	spin_lock_init(&tpu->lock);
> > -	tpu->pdev =3D pdev;
> > -
> >  	tpu->chip.dev =3D &pdev->dev;
> >  	tpu->chip.ops =3D &tpu_pwm_ops;
> > +	tpu->chip.of_xlate =3D of_pwm_xlate_with_flags;
> > +	tpu->chip.of_pwm_n_cells =3D 3;
> >  	tpu->chip.base =3D -1;
> >  	tpu->chip.npwm =3D TPU_CHANNEL_MAX;
> >=20
> > @@ -457,12 +470,26 @@ static int tpu_remove(struct platform_device *pde=
v)
> >  	return 0;
> >  }
> >=20
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id tpu_of_table[] =3D {
> > +	{ .compatible =3D "renesas,tpu-r8a73a4", },
> > +	{ .compatible =3D "renesas,tpu-r8a7740", },
> > +	{ .compatible =3D "renesas,tpu-r8a7790", },
> > +	{ .compatible =3D "renesas,tpu-sh7372", },
> > +	{ .compatible =3D "renesas,tpu", },
> > +	{ },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, tpu_of_table);
> > +#endif
> > +
> >  static struct platform_driver tpu_driver =3D {
> >  	.probe		=3D tpu_probe,
> >  	.remove		=3D tpu_remove,
> >  	.driver		=3D {
> >  		.name	=3D "renesas-tpu-pwm",
> >  		.owner	=3D THIS_MODULE,
> > +		.of_match_table =3D of_match_ptr(tpu_of_table),

I'd like to point this out as an example of why I think aligning on the
=3D here is a bad idea. Eventually you're bound to add a field which is
longer than all the others and therefore can't be aligned consistently.
So instead of coming up with some kind of fancy formatting it often
turns out better to just use a regular single space around =3D. That you
can always consistently use, no matter how long the field names are.

To be clear, I don't expect you to change the patch because of this.

Thierry

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSCI0VAAoJEN0jrNd/PrOhT5MP/1ZjLTN9T7IryjMYAebBw3iJ
+cN0LQFN3Nl4Ma0R3DnsHC1Od3GJCCWmLzQ2djq0YkEaIYggFh+2ae5RPtj1KKti
VS0GgqFhL+pBniR6n/aoasJdoD4+6oCzKnYQhxKDMYzk0YGwycA8+5cmjnPyKB+l
g+gS4Z74t22yFxEHXKy/k1SwxLMw7prY/J85A9lzojUwbFuymo6JkIrlst72FEM1
RMNUes3H9YnseyYXKfNCOayV7yWCmJvKUK4lN8iM1IChxloYfsrWzaTEcHe7oo6p
c7cAGKh5scxHWzCIj39TAQ9eCAWnkfhOkeM385ULtcZb4q7eWNWtC14wzGoJnbnP
DSE+XI58h5QfcyiSuZAl/qRA9/EbxQjdPhmFmwhCMz1doAPeaH+SMjKQH3SFgWLo
rL406uN8DxAP9yYJzvTZwZlTyRbxinnCMiObbD9lm+5B3tFrQUmI8kWDjCSH20mA
aev78DECyAqRUnPzDC2E7ylD8t7q5DpNqbmSrkcuxunHxL48f+AX+YHoEUFXl7e/
mJU0XXCcVb3iKsTKqyKrs989o6hn9xmeNH7+av4DATwwkZpPENKMT60A1jXSjl4u
fMKfTHiVsQ2lCu7wR3PPLUMxPaXaK6TfFGjCFLSJ3TS4Vd3WNgDMoyrHBByvjsqx
ext/0USY5KqPF87BaUs4
=GeUu
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
