From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [RFC PATCH v4 7/8] pwm: Add dummy pwmchip for orphan pwms
Date: Wed, 18 Oct 2017 13:16:16 +0800
Message-ID: <59E6E3A0.2030105@rock-chips.com>
References: <20171017101624.12506-1-jeffy.chen@rock-chips.com> <20171017101624.12506-8-jeffy.chen@rock-chips.com> <20171017124031.GA27983@ulmo> <20171017170428.GB3408@google.com> <CAKdAkRRm9aK3KmPTqtD0d1dENyAq7aXrSEjKXZQMXuJin2hoUA@mail.gmail.com> <20171017184603.yluoukqq6hj2cgcb@sirena.co.uk> <20171017185259.GA41348@google.com> <20171017190501.wa272jreg26tprfo@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:53622 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752532AbdJRFQY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Oct 2017 01:16:24 -0400
In-Reply-To: <20171017190501.wa272jreg26tprfo@sirena.co.uk>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Brian Norris <briannorris@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, lkml <linux-kernel@vger.kernel.org>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Anderson <dianders@chromium.org>, tfiga@chromium.org, seanpaul@chromium.org, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>

Hi guys,

On 10/18/2017 03:05 AM, Mark Brown wrote:
> On Tue, Oct 17, 2017 at 11:53:01AM -0700, Brian Norris wrote:
>> On Tue, Oct 17, 2017 at 07:46:03PM +0100, Mark Brown wrote:
>
>>> I would expect we can get a long way in the DT by doing a pass over the
>>> tree and adding links between device nodes in cases where phandle
>>> references exist.  There is a potential issue with circular links which
>>> I'm just going to handwave away right now but I'd expect that to help
>>> otherwise.
>
>> But I didn't think FDTs encoded type info. So you don't really know
>> whether a phandle is a phandle -- it's just an int (which happens to
>> have a corresponding property in some other node). Are we trusting our
>> DT bindings well enough to say that, for example, we know that in any
>> given device node, a property like 'pwms' must be a phandle to a PWM
>> provider? OK, maybe 'pwms' is a bad example (it's unlikely to get
>> reused, and it has a companion '#pwm-cells' property), but grepping the
>> DT bindings directory shows a ton of one-off properties that contain
>> phandles.
>
> If we're going with the 90% thing we can probably get a long way with a
> whitelist of properties, and we'll be able to take that a lot further
> with the validatable schemas if they ever happen.
>

so it looks like we are going to use device link in common code to fix 
this issue(and also other dependency issue), then i will drop this patch 
and the followed rockchip drm device link patch in next version :)


also the reason why i try to use dummy chip instead is that:

currently we have these devices: rockchip spi device(master) -> 
cros_ec_spi device(child) -> cros_ec_pwm(spi based pwm) -> pwm_bl

i added device link to cros_ec_pwm and pwm_bl, that works well for 
unbind/bind cros_ec_pwm device case, but there's a warning when i try to 
unbind cros_ec_spi:


static void device_links_purge(struct device *dev)
{
...
         list_for_each_entry_safe_reverse(link, ln, 
&dev->links.consumers, s_node) {
                 WARN_ON(link->status != DL_STATE_DORMANT &&
                         link->status != DL_STATE_NONE);        <--- hit 
warning here!
                 __device_link_del(link);
         }


but i checked again, that could due to the way spi core unregester 
children devices. maybe it need to call device_release_driver
