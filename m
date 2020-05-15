From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 03/16] mfd: mfd-core: match device tree node against
 reg property
Date: Fri, 15 May 2020 11:28:48 +0100
Message-ID: <20200515102848.GH271301@dell>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-4-michael@walle.cc>
 <67e90dafd67c285158c2c6f67f92edb7@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <67e90dafd67c285158c2c6f67f92edb7-QKn5cuLxLXY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Bartosz Golaszewski <bgolaszewski-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Wim Van Sebroeck <wim-Q8PRGTgFL9WUCWQAtAn6Ix2eb7JE58TQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Li Yang <leoyang.li-3arQi8VN3Tc@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <maz-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TaqPxH82wqD4g@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Thu, 30 Apr 2020, Michael Walle wrote:

> Hi Lee,
> 
> Am 2020-04-23 19:45, schrieb Michael Walle:
> > There might be multiple children with the device tree compatible, for
> > example if a MFD has multiple instances of the same function. In this
> > case only the first is matched and the other children get a wrong
> > of_node reference.
> > Add a new option to match also against the unit address of the child
> > node. Additonally, a new helper OF_MFD_CELL_REG is added.
> 
> 
> Do you think this is feasible? I guess this is the biggest uncertainty
> for me at the moment in this patch series.

I think it sounds fine in principle.  So long as it doesn't change the
existing behaviour when of_reg isn't set.

> > Signed-off-by: Michael Walle <michael-QKn5cuLxLXY@public.gmane.org>
> > ---
> >  drivers/mfd/mfd-core.c   | 29 ++++++++++++++++++++---------
> >  include/linux/mfd/core.h | 26 ++++++++++++++++++++------
> >  2 files changed, 40 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index e735565969b3..4ecb376338f7 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -117,6 +117,7 @@ static int mfd_add_device(struct device *parent, int
> > id,
> >  	struct device_node *np = NULL;
> >  	int ret = -ENOMEM;
> >  	int platform_id;
> > +	u32 of_reg;
> >  	int r;
> > 
> >  	if (id == PLATFORM_DEVID_AUTO)
> > @@ -151,16 +152,26 @@ static int mfd_add_device(struct device *parent,
> > int id,
> > 
> >  	if (parent->of_node && cell->of_compatible) {
> >  		for_each_child_of_node(parent->of_node, np) {
> > -			if (of_device_is_compatible(np, cell->of_compatible)) {
> > -				if (!of_device_is_available(np)) {
> > -					/* Ignore disabled devices error free */
> > -					ret = 0;
> > -					goto fail_alias;
> > -				}
> > -				pdev->dev.of_node = np;
> > -				pdev->dev.fwnode = &np->fwnode;
> > -				break;
> > +			if (!of_device_is_compatible(np, cell->of_compatible))
> > +				continue;
> > +
> > +			/* also match the unit address if set */

Please use correct grammar in comments (leaving off the full-stop).

> > +			if (cell->of_reg & MFD_OF_REG_VALID) {
> > +				if (of_property_read_u32(np, "reg", &of_reg))
> > +					continue;
> > +				if ((cell->of_reg & MFD_OF_REG_MASK) != of_reg)
> > +					continue;
> >  			}
> > +
> > +			if (!of_device_is_available(np)) {
> > +				/* Ignore disabled devices error free */
> > +				ret = 0;
> > +				goto fail_alias;
> > +			}
> > +
> > +			pdev->dev.of_node = np;
> > +			pdev->dev.fwnode = &np->fwnode;
> > +			break;
> >  		}
> >  	}
> > 
> > diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> > index d01d1299e49d..c2c0ad6b14f3 100644
> > --- a/include/linux/mfd/core.h
> > +++ b/include/linux/mfd/core.h
> > @@ -13,8 +13,11 @@
> >  #include <linux/platform_device.h>
> > 
> >  #define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
> > +#define MFD_OF_REG_VALID	BIT(31)

What about 64bit platforms?

> > +#define MFD_OF_REG_MASK		GENMASK(30, 0)
> > 
> > -#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,
> > _match)\
> > +#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
> > +		     _of_reg, _match)					\
> >  	{								\
> >  		.name = (_name),					\
> >  		.resources = (_res),					\
> > @@ -22,24 +25,32 @@
> >  		.platform_data = (_pdata),				\
> >  		.pdata_size = (_pdsize),				\
> >  		.of_compatible = (_compat),				\
> > +		.of_reg = (_of_reg),					\
> >  		.acpi_match = (_match),					\
> >  		.id = (_id),						\
> >  	}
> > 
> > +#define OF_MFD_CELL_REG(_name, _res, _pdata, _pdsize, _id, _compat,	\
> > +			_of_reg)					\
> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
> > +		     ((_of_reg) | MFD_OF_REG_VALID), NULL)		\
> > +
> >  #define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat)		\
> > -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)	\
> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
> > +		     0, NULL)						\
> > 
> >  #define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match)	\
> > -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)	\
> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0,	\
> > +		     _match)						\
> > 
> >  #define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id)		\
> > -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)	\
> > +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, NULL) \
> > 
> >  #define MFD_CELL_RES(_name, _res)					\
> > -	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, NULL)		\
> > +	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, 0, NULL)		\
> > 
> >  #define MFD_CELL_NAME(_name)						\
> > -	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)		\
> > +	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, 0, NULL)		\
> > 
> >  struct irq_domain;
> >  struct property_entry;
> > @@ -78,6 +89,9 @@ struct mfd_cell {
> >  	 */
> >  	const char		*of_compatible;
> > 
> > +	/* matching the reg property if set */

Proper grammar please.

"OF unit address for device matching"

> > +	unsigned int		of_reg;
> > +
> >  	/* Matches ACPI */
> >  	const struct mfd_cell_acpi_match	*acpi_match;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
