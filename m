From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/7] input: keyboard: Add support for Azoteq
 IQS620A/621/622/624/625
Date: Mon, 20 Jan 2020 22:55:33 -0800
Message-ID: <20200121065533.GN47797@dtor-ws>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-4-git-send-email-jeff@labundy.com>
 <20200117213330.GF47797@dtor-ws>
 <20200119224025.GA28865@labundy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200119224025.GA28865@labundy.com>
Sender: linux-input-owner@vger.kernel.org
To: Jeff LaBundy <jeff@labundy.com>
Cc: "lee.jones@linaro.org" <lee.jones@linaro.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>
List-Id: linux-pwm@vger.kernel.org

On Sun, Jan 19, 2020 at 10:40:31PM +0000, Jeff LaBundy wrote:
> On Fri, Jan 17, 2020 at 01:33:30PM -0800, dmitry.torokhov@gmail.com wrote:
> > On Fri, Jan 17, 2020 at 02:35:46AM +0000, Jeff LaBundy wrote:
> > > +
> > > +	ret = device_property_read_u32_array(&pdev->dev, "linux,keycodes",
> > > +					     iqs62x_keys->keycode,
> > > +					     iqs62x_keys->keycodemax);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "Failed to read keycodes: %d\n", ret);
> > > +		return ret;
> > > +	}
> > 
> > I wonder why you can't simply use
> > 
> > 	error = device_property_read_u32_array(&pdev->dev, "linux,keycodes",
> > 						iqs62x_keys->keycode,
> > 						IQS62X_NUM_KEYS);
> > 
> > Are you concerned with someone trying to set up keys that are not
> > actually exposed later via EVOCSKEYCODES and that is why you are
> > limiting keycodemax?
> 
> When I try this, I find that device_property_read_u32_array returns -EOVERFLOW
> for arrays with fewer than IQS62X_NUM_KEYS elements. To avoid forcing users to
> pad the array all the way out to IQS62X_NUM_KEYS in the case of simple channel
> assignments (like those in the example bindings), keycodemax must be passed to
> device_property_read_u32_array which means it must be limited before-hand. The
> same method seems to be used in other drivers as well (e.g. mpr121_touchkey).

Ah, indeed, ignore me here please.

...

> > > +MODULE_AUTHOR("Jeff LaBundy <jeff@labundy.com>");
> > > +MODULE_DESCRIPTION("Azoteq IQS620A/621/622/624/625 Keys and Switches");
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_ALIAS("platform:" IQS62X_DRV_NAME_KEYS);
> > 
> > Otherwise
> > 
> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > I suppose it will be merged through MFD?
> 
> That's the plan; Lee confirmed this would be OK once the series is ready. Just
> as a heads up, I expect minor changes to this and other patches as iqs62x.h is
> hardened (e.g. "iqs62x->map" --> "iqs62x->regmap"). I assume you're OK with me
> keeping your Acked-by unless there are major changes, but let me know if you'd
> prefer I didn't.

Yes, please keep Acked-by unless there is significant rework.

Thanks.

-- 
Dmitry
