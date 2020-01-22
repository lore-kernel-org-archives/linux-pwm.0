From: Jeff LaBundy <jeff@labundy.com>
Subject: Re: [PATCH v4 5/7] iio: temperature: Add support for Azoteq IQS620AT
 temperature sensor
Date: Wed, 22 Jan 2020 03:28:28 +0000
Message-ID: <20200122032821.GA29969@labundy.com>
References: <1579228475-6681-1-git-send-email-jeff@labundy.com>
 <1579228475-6681-6-git-send-email-jeff@labundy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1579228475-6681-6-git-send-email-jeff@labundy.com>
Content-Language: en-US
Content-ID: <7F2C989C4E0F6B46B9CC1A0A730BEEE0@namprd08.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
To: "lee.jones@linaro.org" <lee.jones@linaro.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>
List-Id: linux-pwm@vger.kernel.org

Hi Jonathan,

I just wanted to give a heads up that I'm making a couple of very minor
changes to the lot of IIO patches in this series in response to changes
to include/linux/mfd/iqs62x.h for v5, namely:

- Replaced iqs62x->map with iqs62x->regmap
- Dropped #defines for platform_driver name and alias in favor of the
  actual string names (e.g. IQS620_DRV_NAME_TEMP --> "iqs620at-temp")

For small changes like these, I plan to retain your Reviewed-by trailer
when I send out v5 even though the file would have changed slightly. If
you would prefer I let you re-review first, please let me know.

On Thu, Jan 16, 2020 at 08:36:08PM -0600, Jeff LaBundy wrote:
> This patch adds support for the Azoteq IQS620AT temperature sensor,
> capable of reporting its absolute die temperature.
>=20
> Signed-off-by: Jeff LaBundy <jeff@labundy.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> Changes in v4:
>   - None
>=20
> Changes in v3:
>   - Added Reviewed-by trailer
>=20
> Changes in v2:
>   - Moved the driver from hwmon to iio
>   - Merged 'Copyright' and 'Author' lines into one in introductory commen=
ts
>   - Replaced 'error' with 'ret' throughout
>   - Eliminated tabbed alignment of platform_driver struct members
>   - Changed Kconfig "depends on" logic to MFD_IQS62X || COMPILE_TEST
>=20
>  drivers/iio/temperature/Kconfig         | 10 ++++
>  drivers/iio/temperature/Makefile        |  1 +
>  drivers/iio/temperature/iqs620at-temp.c | 97 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 108 insertions(+)
>  create mode 100644 drivers/iio/temperature/iqs620at-temp.c
>=20

Kind regards,
Jeff LaBundy
