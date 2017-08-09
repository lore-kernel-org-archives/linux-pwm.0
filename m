From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] pwm: Convert to using %pOF instead of full_name
Date: Wed, 9 Aug 2017 17:12:55 -0500
Message-ID: <CAL_Jsq+Oumkr=Npktxz2RnC9EMf8QWgvaw8SKx1uCLbjQg==Vg@mail.gmail.com>
References: <20170718214339.7774-45-robh@kernel.org> <20170725113854.GA22355@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170725113854.GA22355@ulmo>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Linux PWM List <linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Tue, Jul 25, 2017 at 6:38 AM, Thierry Reding
<thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Jul 18, 2017 at 04:43:25PM -0500, Rob Herring wrote:
>> Now that we have a custom printf format specifier, convert users of
>> full_name to use %pOF instead. This is preparation to remove storing
>> of the full path string for each node.
>>
>> Signed-off-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
>> Cc: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
>> Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> Cc: linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>> ---
>>  drivers/pwm/pwm-meson.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Applied, thanks.

This is not showing up in -next.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
