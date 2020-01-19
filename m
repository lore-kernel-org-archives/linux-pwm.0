From: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 3/7] input: keyboard: Add support for Azoteq
 IQS620A/621/622/624/625
Date: Sun, 19 Jan 2020 22:40:31 +0000
Message-ID: <20200119224025.GA28865@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-4-git-send-email-jeff@labundy.com>
 <20200117213330.GF47797@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200117213330.GF47797@dtor-ws>
Content-Language: en-US
Content-ID: <D3EF35AA8512B74A9CD97B07DE10CAB5-UmvZKMv7CrqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "knaack.h-Mmb7MZpHnFY@public.gmane.org" <knaack.h-Mmb7MZpHnFY@public.gmane.org>, "lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org" <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, "pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org" <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pwm@vger.kernel.org

Hi Dmitry,

Thank you for your continued support on this project.

On Fri, Jan 17, 2020 at 01:33:30PM -0800, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> Hi Jeff,
>=20
> On Fri, Jan 17, 2020 at 02:35:46AM +0000, Jeff LaBundy wrote:
> > This patch adds key and switch support for the Azoteq IQS620A,
> > IQS621, IQS622, IQS624 and IQS625 multi-function sensors.
> >=20
> > Signed-off-by: Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
> > ---
> > Changes in v4:
> >   - None
> >=20
> > Changes in v3:
> >   - None
> >=20
> > Changes in v2:
> >   - Merged 'Copyright' and 'Author' lines into one in introductory comm=
ents
> >   - Replaced 'error' with 'ret' throughout
> >   - Updated iqs62x_keys_parse_prop to use unified device property inter=
face
> >   - Clarified the comment in iqs62x_keys_notifier to state that wheel u=
p or
> >     down events elicit an emulated release cycle
> >   - Eliminated tabbed alignment of platform_driver struct members
> >=20
> >  drivers/input/keyboard/Kconfig       |  10 ++
> >  drivers/input/keyboard/Makefile      |   1 +
> >  drivers/input/keyboard/iqs62x-keys.c | 340 +++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 351 insertions(+)
> >  create mode 100644 drivers/input/keyboard/iqs62x-keys.c
> >=20
> > diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kc=
onfig
> > index 4706ff0..28de965 100644
> > --- a/drivers/input/keyboard/Kconfig
> > +++ b/drivers/input/keyboard/Kconfig
> > @@ -663,6 +663,16 @@ config KEYBOARD_IPAQ_MICRO
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called ipaq-micro-keys.
> >=20
> > +config KEYBOARD_IQS62X
> > +	tristate "Azoteq IQS620A/621/622/624/625 keys and switches"
> > +	depends on MFD_IQS62X
> > +	help
> > +	  Say Y here to enable key and switch support for the Azoteq IQS620A,
> > +	  IQS621, IQS622, IQS624 and IQS625 multi-function sensors.
> > +
> > +	  To compile this driver as a module, choose M here: the module will
> > +	  be called iqs62x-keys.
> > +
> >  config KEYBOARD_OMAP
> >  	tristate "TI OMAP keypad support"
> >  	depends on ARCH_OMAP1
> > diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/M=
akefile
> > index f5b1752..1d689fd 100644
> > --- a/drivers/input/keyboard/Makefile
> > +++ b/drivers/input/keyboard/Makefile
> > @@ -28,6 +28,7 @@ obj-$(CONFIG_KEYBOARD_TCA8418)		+=3D tca8418_keypad.o
> >  obj-$(CONFIG_KEYBOARD_HIL)		+=3D hil_kbd.o
> >  obj-$(CONFIG_KEYBOARD_HIL_OLD)		+=3D hilkbd.o
> >  obj-$(CONFIG_KEYBOARD_IPAQ_MICRO)	+=3D ipaq-micro-keys.o
> > +obj-$(CONFIG_KEYBOARD_IQS62X)		+=3D iqs62x-keys.o
> >  obj-$(CONFIG_KEYBOARD_IMX)		+=3D imx_keypad.o
> >  obj-$(CONFIG_KEYBOARD_IMX_SC_KEY)	+=3D imx_sc_key.o
> >  obj-$(CONFIG_KEYBOARD_HP6XX)		+=3D jornada680_kbd.o
> > diff --git a/drivers/input/keyboard/iqs62x-keys.c b/drivers/input/keybo=
ard/iqs62x-keys.c
> > new file mode 100644
> > index 0000000..b477334
> > --- /dev/null
> > +++ b/drivers/input/keyboard/iqs62x-keys.c
> > @@ -0,0 +1,340 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Azoteq IQS620A/621/622/624/625 Keys and Switches
> > + *
> > + * Copyright (C) 2019 Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/input.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/iqs62x.h>
> > +#include <linux/module.h>
> > +#include <linux/notifier.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +enum {
> > +	IQS62X_SW_HALL_N,
> > +	IQS62X_SW_HALL_S,
> > +};
> > +
> > +static const char * const iqs62x_switch_names[] =3D {
> > +	[IQS62X_SW_HALL_N] =3D "hall-switch-north",
> > +	[IQS62X_SW_HALL_S] =3D "hall-switch-south",
> > +};
> > +
> > +struct iqs62x_switch_desc {
> > +	enum iqs62x_event_flag flag;
> > +	unsigned int code;
> > +	bool enabled;
> > +};
> > +
> > +struct iqs62x_keys_private {
> > +	struct iqs62x_core *iqs62x;
> > +	struct input_dev *input;
> > +	struct notifier_block notifier;
> > +	struct iqs62x_switch_desc switches[ARRAY_SIZE(iqs62x_switch_names)];
> > +	unsigned int keycode[IQS62X_NUM_KEYS];
> > +	unsigned int keycodemax;
> > +	u8 interval;
> > +};
> > +
> > +static int iqs62x_keys_parse_prop(struct platform_device *pdev,
> > +				  struct iqs62x_keys_private *iqs62x_keys)
> > +{
> > +	struct fwnode_handle *child;
> > +	unsigned int val;
> > +	int ret, i;
> > +
> > +	ret =3D device_property_read_u32_array(&pdev->dev, "linux,keycodes",
> > +					     NULL, 0);
>=20
> You can use device_property_count_u32().

Sure thing, will do.

>=20
> > +	if (ret > IQS62X_NUM_KEYS) {
> > +		dev_err(&pdev->dev, "Too many keycodes present\n");
> > +		return -EINVAL;
> > +	} else if (ret < 0) {
> > +		dev_err(&pdev->dev, "Failed to count keycodes: %d\n", ret);
> > +		return ret;
> > +	}
> > +	iqs62x_keys->keycodemax =3D ret;
> > +
> > +	ret =3D device_property_read_u32_array(&pdev->dev, "linux,keycodes",
> > +					     iqs62x_keys->keycode,
> > +					     iqs62x_keys->keycodemax);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to read keycodes: %d\n", ret);
> > +		return ret;
> > +	}
>=20
> I wonder why you can't simply use
>=20
> 	error =3D device_property_read_u32_array(&pdev->dev, "linux,keycodes",
> 						iqs62x_keys->keycode,
> 						IQS62X_NUM_KEYS);
>=20
> Are you concerned with someone trying to set up keys that are not
> actually exposed later via EVOCSKEYCODES and that is why you are
> limiting keycodemax?

When I try this, I find that device_property_read_u32_array returns -EOVERF=
LOW
for arrays with fewer than IQS62X_NUM_KEYS elements. To avoid forcing users=
 to
pad the array all the way out to IQS62X_NUM_KEYS in the case of simple chan=
nel
assignments (like those in the example bindings), keycodemax must be passed=
 to
device_property_read_u32_array which means it must be limited before-hand. =
The
same method seems to be used in other drivers as well (e.g. mpr121_touchkey=
).

>=20
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
> > +		child =3D device_get_named_child_node(&pdev->dev,
> > +						    iqs62x_switch_names[i]);
> > +		if (!child)
> > +			continue;
> > +
> > +		ret =3D fwnode_property_read_u32(child, "linux,code", &val);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Failed to read switch code: %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +		iqs62x_keys->switches[i].code =3D val;
> > +		iqs62x_keys->switches[i].enabled =3D true;
> > +
> > +		if (fwnode_property_present(child, "azoteq,use-prox"))
> > +			iqs62x_keys->switches[i].flag =3D (i =3D=3D IQS62X_SW_HALL_N ?
> > +							 IQS62X_EVENT_HALL_N_P :
> > +							 IQS62X_EVENT_HALL_S_P);
> > +		else
> > +			iqs62x_keys->switches[i].flag =3D (i =3D=3D IQS62X_SW_HALL_N ?
> > +							 IQS62X_EVENT_HALL_N_T :
> > +							 IQS62X_EVENT_HALL_S_T);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int iqs62x_keys_init(struct iqs62x_keys_private *iqs62x_keys)
> > +{
> > +	struct iqs62x_core *iqs62x =3D iqs62x_keys->iqs62x;
> > +	enum iqs62x_event_flag flag;
> > +	unsigned int event_mask_reg;
> > +	unsigned int event_mask =3D 0;
> > +	unsigned int val;
> > +	int ret, i;
> > +
> > +	switch (iqs62x->dev_desc->prod_num) {
> > +	case IQS620_PROD_NUM:
> > +	case IQS621_PROD_NUM:
> > +	case IQS622_PROD_NUM:
> > +		event_mask_reg =3D IQS620_GLBL_EVENT_MASK;
> > +
> > +		/*
> > +		 * Discreet button, hysteresis and SAR UI flags represent keys
> > +		 * and are unmasked if mapped to a valid keycode.
> > +		 */
> > +		for (i =3D 0; i < iqs62x_keys->keycodemax; i++) {
> > +			if (iqs62x_keys->keycode[i] =3D=3D KEY_RESERVED)
> > +				continue;
> > +
> > +			if (iqs62x_events[i].reg =3D=3D IQS62X_EVENT_PROX)
> > +				event_mask |=3D iqs62x->dev_desc->prox_mask;
> > +			else if (iqs62x_events[i].reg =3D=3D IQS62X_EVENT_HYST)
> > +				event_mask |=3D (iqs62x->dev_desc->hyst_mask |
> > +					       iqs62x->dev_desc->sar_mask);
> > +		}
> > +
> > +		ret =3D regmap_read(iqs62x->map, iqs62x->dev_desc->hall_flags,
> > +				  &val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/*
> > +		 * Hall UI flags represent switches and are unmasked if their
> > +		 * corresponding child nodes are present.
> > +		 */
> > +		for (i =3D 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++) {
> > +			if (!(iqs62x_keys->switches[i].enabled))
> > +				continue;
> > +
> > +			flag =3D iqs62x_keys->switches[i].flag;
> > +
> > +			if (iqs62x_events[flag].reg !=3D IQS62X_EVENT_HALL)
> > +				continue;
> > +
> > +			event_mask |=3D iqs62x->dev_desc->hall_mask;
> > +
> > +			input_report_switch(iqs62x_keys->input,
> > +					    iqs62x_keys->switches[i].code,
> > +					    (val & iqs62x_events[flag].mask) =3D=3D
> > +					    iqs62x_events[flag].val);
> > +		}
> > +
> > +		input_sync(iqs62x_keys->input);
> > +		break;
> > +
> > +	case IQS624_PROD_NUM:
> > +		event_mask_reg =3D IQS624_HALL_UI;
> > +
> > +		/*
> > +		 * Interval change events represent keys and are unmasked if
> > +		 * either wheel movement flag is mapped to a valid keycode.
> > +		 */
> > +		if (iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP] !=3D KEY_RESERVED)
> > +			event_mask |=3D IQS624_HALL_UI_INT_EVENT;
> > +
> > +		if (iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN] !=3D KEY_RESERVED)
> > +			event_mask |=3D IQS624_HALL_UI_INT_EVENT;
> > +
> > +		ret =3D regmap_read(iqs62x->map, iqs62x->dev_desc->interval,
> > +				  &val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		iqs62x_keys->interval =3D val;
> > +		break;
> > +
> > +	default:
> > +		return 0;
> > +	}
> > +
> > +	return regmap_update_bits(iqs62x->map, event_mask_reg, event_mask, 0)=
;
> > +}
> > +
> > +static int iqs62x_keys_notifier(struct notifier_block *notifier,
> > +				unsigned long event_flags, void *context)
> > +{
> > +	struct iqs62x_event_data *event_data =3D context;
> > +	struct iqs62x_keys_private *iqs62x_keys;
> > +	int ret, i;
> > +
> > +	iqs62x_keys =3D container_of(notifier, struct iqs62x_keys_private,
> > +				   notifier);
> > +
> > +	if (event_flags & BIT(IQS62X_EVENT_SYS_RESET)) {
> > +		ret =3D iqs62x_keys_init(iqs62x_keys);
> > +		if (ret) {
> > +			dev_err(iqs62x_keys->input->dev.parent,
> > +				"Failed to re-initialize device: %d\n", ret);
> > +			return NOTIFY_BAD;
> > +		}
> > +
> > +		return NOTIFY_OK;
> > +	}
> > +
> > +	for (i =3D 0; i < iqs62x_keys->keycodemax; i++) {
> > +		if (iqs62x_events[i].reg =3D=3D IQS62X_EVENT_WHEEL &&
> > +		    event_data->interval =3D=3D iqs62x_keys->interval)
> > +			continue;
> > +
> > +		input_report_key(iqs62x_keys->input, iqs62x_keys->keycode[i],
> > +				 event_flags & BIT(i));
> > +	}
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++)
> > +		if (iqs62x_keys->switches[i].enabled)
> > +			input_report_switch(iqs62x_keys->input,
> > +					    iqs62x_keys->switches[i].code,
> > +					    event_flags &
> > +					    BIT(iqs62x_keys->switches[i].flag));
> > +
> > +	input_sync(iqs62x_keys->input);
> > +
> > +	if (event_data->interval =3D=3D iqs62x_keys->interval)
> > +		return NOTIFY_OK;
> > +
> > +	/*
> > +	 * Each frame contains at most one wheel event (up or down), in which
> > +	 * case a complementary release cycle is emulated.
> > +	 */
> > +	if (event_flags & BIT(IQS62X_EVENT_WHEEL_UP)) {
> > +		input_report_key(iqs62x_keys->input,
> > +				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_UP],
> > +				 0);
> > +		input_sync(iqs62x_keys->input);
> > +	} else if (event_flags & BIT(IQS62X_EVENT_WHEEL_DN)) {
> > +		input_report_key(iqs62x_keys->input,
> > +				 iqs62x_keys->keycode[IQS62X_EVENT_WHEEL_DN],
> > +				 0);
> > +		input_sync(iqs62x_keys->input);
> > +	}
> > +
> > +	iqs62x_keys->interval =3D event_data->interval;
> > +
> > +	return NOTIFY_OK;
> > +}
> > +
> > +static int iqs62x_keys_probe(struct platform_device *pdev)
> > +{
> > +	struct iqs62x_core *iqs62x =3D dev_get_drvdata(pdev->dev.parent);
> > +	struct iqs62x_keys_private *iqs62x_keys;
> > +	struct input_dev *input;
> > +	int ret, i;
> > +
> > +	iqs62x_keys =3D devm_kzalloc(&pdev->dev, sizeof(*iqs62x_keys),
> > +				   GFP_KERNEL);
> > +	if (!iqs62x_keys)
> > +		return -ENOMEM;
> > +
> > +	platform_set_drvdata(pdev, iqs62x_keys);
> > +
> > +	ret =3D iqs62x_keys_parse_prop(pdev, iqs62x_keys);
> > +	if (ret)
> > +		return ret;
> > +
> > +	input =3D devm_input_allocate_device(&pdev->dev);
> > +	if (!input)
> > +		return -ENOMEM;
> > +
> > +	input->keycodemax =3D iqs62x_keys->keycodemax;
> > +	input->keycode =3D iqs62x_keys->keycode;
> > +	input->keycodesize =3D sizeof(*iqs62x_keys->keycode);
> > +
> > +	input->name =3D iqs62x->dev_desc->dev_name;
> > +	input->id.bustype =3D BUS_I2C;
> > +
> > +	__set_bit(EV_KEY, input->evbit);
> > +
> > +	for (i =3D 0; i < iqs62x_keys->keycodemax; i++)
> > +		__set_bit(iqs62x_keys->keycode[i], input->keybit);
> > +
> > +	__clear_bit(KEY_RESERVED, input->keybit);

It occurs to me that we can also collapse the __set_bit ... __clear_bit log=
ic
above into the following:

for (i =3D 0; i < iqs62x_keys->keycodemax; i++)
	if (iqs62x_keys->keycode[i] !=3D KEY_RESERVED)
		input_set_capability(input, EV_KEY, iqs62x_keys->keycode[i]);

Since this seems straightforward enough, I plan on sneaking it into v5 alon=
g
with the change below while keeping your Acked-by. If you have any objectio=
n,
please let me know.

> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(iqs62x_keys->switches); i++)
> > +		if (iqs62x_keys->switches[i].enabled) {
> > +			__set_bit(EV_SW, input->evbit);
> > +			__set_bit(iqs62x_keys->switches[i].code, input->swbit);
>=20
> input_set_capability(input, EV_SW, iqs62x_keys->switches[i].code)

Sure thing, will do.

>=20
> > +		}
> > +
> > +	iqs62x_keys->iqs62x =3D iqs62x;
> > +	iqs62x_keys->input =3D input;
> > +
> > +	ret =3D iqs62x_keys_init(iqs62x_keys);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to initialize device: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D input_register_device(iqs62x_keys->input);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to register device: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	iqs62x_keys->notifier.notifier_call =3D iqs62x_keys_notifier;
> > +	ret =3D blocking_notifier_chain_register(&iqs62x_keys->iqs62x->nh,
> > +					       &iqs62x_keys->notifier);
> > +	if (ret)
> > +		dev_err(&pdev->dev, "Failed to register notifier: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static int iqs62x_keys_remove(struct platform_device *pdev)
> > +{
> > +	struct iqs62x_keys_private *iqs62x_keys =3D platform_get_drvdata(pdev=
);
> > +	int ret;
> > +
> > +	ret =3D blocking_notifier_chain_unregister(&iqs62x_keys->iqs62x->nh,
> > +						 &iqs62x_keys->notifier);
> > +	if (ret)
> > +		dev_err(&pdev->dev, "Failed to unregister notifier: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static struct platform_driver iqs62x_keys_platform_driver =3D {
> > +	.driver =3D {
> > +		.name =3D IQS62X_DRV_NAME_KEYS,
> > +	},
> > +	.probe =3D iqs62x_keys_probe,
> > +	.remove =3D iqs62x_keys_remove,
> > +};
> > +module_platform_driver(iqs62x_keys_platform_driver);
> > +
> > +MODULE_AUTHOR("Jeff LaBundy <jeff-Sk+WRT7NHmFBDgjK7y7TUQ@public.gmane.org>");
> > +MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 Keys and Switches")=
;
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:" IQS62X_DRV_NAME_KEYS);
>=20
> Otherwise
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>=20
> I suppose it will be merged through MFD?

That's the plan; Lee confirmed this would be OK once the series is ready. J=
ust
as a heads up, I expect minor changes to this and other patches as iqs62x.h=
 is
hardened (e.g. "iqs62x->map" --> "iqs62x->regmap"). I assume you're OK with=
 me
keeping your Acked-by unless there are major changes, but let me know if yo=
u'd
prefer I didn't.

>=20
> Thanks.
>=20
> --=20
> Dmitry

Kind regards,
Jeff LaBundy
