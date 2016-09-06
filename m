From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 1/4] pwm: Add support for Meson PWM Controller
Date: Tue, 6 Sep 2016 23:24:16 +0200
Message-ID: <CAFBinCBW_-NrQaKOML8_Y_th9P1Ozsj4UXxwSWM_LCtt8NWCDA@mail.gmail.com>
References: <1471880193-21879-1-git-send-email-narmstrong@baylibre.com>
 <1471880193-21879-2-git-send-email-narmstrong@baylibre.com>
 <CAFBinCA3PoR_=+f8aU-Trg8uKWWXkkBOtrQUaXbdsb8E-fdM0g@mail.gmail.com> <20160905095321.GB31424@ulmo.ba.sec>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33508 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755954AbcIFVYj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 6 Sep 2016 17:24:39 -0400
In-Reply-To: <20160905095321.GB31424@ulmo.ba.sec>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>, carlo@caione.org, khilman@baylibre.com, linux-pwm@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Thierry,

On Mon, Sep 5, 2016 at 11:53 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> As mentioned in another reply in this thread I ended up restructuring
> the driver a little before applying it to the PWM tree. I don't /think/
> there are any functional changes, so I left your Tested-by in place, but
> it would be great if you could retest and confirm, just to make sure.
>
> The driver is in the for-4.9/drivers branch of the PWM tree:
>
>         https://git.kernel.org/cgit/linux/kernel/git/thierry.reding/linux-pwm.git/log/?h=for-4.9/drivers
I have tested it with the updated Neil sent today: [0]
This is still working fine for me (driving the LPO clock of an AP6330
SDIO wifi chip).

Please note that I don't have a scope to measure the actual signal,
but I guess it's fine since my AP6330 is happy.

So feel free to keep my:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards,
Martin


[0] https://github.com/superna9999/linux/releases/tag/amlogic/v4.8/pwm-for-next-for-v4
