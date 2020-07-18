From: Jingoo Han <jingoohan1@gmail.com>
Subject: Re: [PATCH v4 05/20] backlight: improve backlight_device
 documentation
Date: Sat, 18 Jul 2020 05:18:39 +0000
Message-ID: <SL2P216MB0105B428FFAB66BDA245B814AA7D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
References: <20200703184546.144664-1-sam@ravnborg.org>
 <20200703184546.144664-6-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20200703184546.144664-6-sam@ravnborg.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Lee Jones <lee.jones@linaro.org>, Daniel Thompson <daniel.thompson@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe Kleine-Konig <u.kle>
List-Id: linux-pwm@vger.kernel.org

On 7/3/20, 2:46 PM, Sam Ravnborg wrote:
>
> Improve the documentation for backlight_device and
> adapt it to kernel-doc style.
>
> The updated documentation is more strict on how locking is used.
> With the update neither update_lock nor ops_lock may be used
> outside the backlight core.
> This restriction was introduced to keep the locking simple
> by keeping it in the core.
> It was verified that this documents the current state by renaming
> update_lock =3D> bl_update_lock and ops_lock =3D> bl_ops_lock.
> The rename did not reveal any uses outside the backlight core.
> The rename is NOT part of this patch.
>
> v3:
>   - Update changelog to explain locking details (Daniel)
>
> v2:
>   - Add short intro to all fields (Daniel)
>   - Updated description of update_lock (Daniel)
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
 > Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>

It looks good!
Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

For the rebase, if you don't know which branch of maintainer's git can be u=
sed,
linux-next tree [1] is useful. The linux-next git collects all next branche=
s from=20
other maintainers' git every day.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/

Thank you.

Best regards,
Jingoo Han

> ---
>  include/linux/backlight.h | 72 ++++++++++++++++++++++++++-------------
>  1 file changed, 49 insertions(+), 23 deletions(-)
.....
