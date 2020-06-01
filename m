From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v3 05/13] backlight: improve backlight_device
 documentation
Date: Mon, 1 Jun 2020 11:23:23 +0100
Message-ID: <20200601102323.5wmnr7pj653zy3t5@holly.lan>
References: <20200601065207.492614-1-sam@ravnborg.org>
 <20200601065207.492614-6-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgFAKX2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 06:23:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112F0C061A0E
        for <linux-pwm@vger.kernel.org>; Mon,  1 Jun 2020 03:23:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e1so10953591wrt.5
        for <linux-pwm@vger.kernel.org>; Mon, 01 Jun 2020 03:23:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200601065207.492614-6-sam@ravnborg.org>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Andy Gross <agross@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, David Airlie <airlied@linux.ie>, Emil Velikov <emil.l.velikov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, patches@opensource.cirrus.com, Support Opensource <support.opensource@diasemi.com>, Thierry Reding <thierry.reding@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, Uwe

On Mon, Jun 01, 2020 at 08:51:59AM +0200, Sam Ravnborg wrote:
> Improve the documentation for backlight_device and
> adapt it to kernel-doc style.
> 
> v2:
>   - Add short intro to all fields (Daniel)
>   - Updated description of update_lock (Daniel)

I like the update... but it doesn't cover what I was commenting on.


> diff --git a/include/linux/backlight.h b/include/linux/backlight.h
> index 69a20da03035..cae1af95dd9d 100644
> --- a/include/linux/backlight.h
> +++ b/include/linux/backlight.h
> @@ -14,21 +14,6 @@
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
>  
> -/* Notes on locking:
> - *
> - * backlight_device->ops_lock is an internal backlight lock protecting the
> - * ops pointer and no code outside the core should need to touch it.
> - *
> - * Access to update_status() is serialised by the update_lock mutex since
> - * most drivers seem to need this and historically get it wrong.
> - *
> - * Most drivers don't need locking on their get_brightness() method.
> - * If yours does, you need to implement it in the driver. You can use the
> - * update_lock mutex if appropriate.

This explicitly says that drivers are permitted to use update_lock in
their get_brightness() method.


> - *
> - * Any other use of the locks below is probably wrong.
> - */
> -
>  enum backlight_update_reason {
>  	BACKLIGHT_UPDATE_HOTKEY,
>  	BACKLIGHT_UPDATE_SYSFS,
> @@ -215,30 +200,71 @@ struct backlight_properties {
>  	enum backlight_scale scale;
>  };
>  
> +/**
> + * struct backlight_device - backlight device data
> + *
> + * This structure holds all data required by a backlight device.
> + */
>  struct backlight_device {
> -	/* Backlight properties */
> +	/**
> +	 * @props: Backlight properties
> +	 */
>  	struct backlight_properties props;
>  
> -	/* Serialise access to update_status method */
> +	/**
> +	 * @update_lock: The lock used when calling the update_status() operation.
> +	 *
> +	 * update_lock is an internal backlight lock that serialise access
> +	 * to the update_status() operation. The backlight core holds the update_lock
> +	 * when calling the update_status() operation. The update_lock shall not
> +	 * be used by backlight drivers.
> +	 */

This contradicts the original comment about locking.

I'm fairly neutral about the change (AFAICT no driver actually ever
uses update_lock from get_brightness) but if we add new documentation
that flatly contradicts old documentary comments then I'd expect to
see something in the patch description explaining that the change
really is deliberate (and why it is a good change).


Daniel.
