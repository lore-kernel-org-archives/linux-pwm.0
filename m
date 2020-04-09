From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: (EXT) Re: [PATCH 1/4] pwm: pca9685: remove unused duty_cycle
 struct element
Date: Thu, 9 Apr 2020 07:42:05 -0400
Message-ID: <CAGngYiWz-XCenfWAnTFR9jKuQpGQXi26B5-K0T3dvB_g54h6qA@mail.gmail.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226151034.7i3h5blmrwre2yzg@pengutronix.de> <32ec35c2b3da119dd2c7bc09742796a0d8a9607e.camel@ew.tq-group.com>
 <20200330151231.GA1650@workstation.tuxnet> <CAGngYiUe-tihBJUcXQ738_5aA9pzgp_-NSs4iCrz3eWO6rMukA@mail.gmail.com>
 <20200404173546.GA55833@workstation.tuxnet> <CAGngYiWpO_N+t74k-==RNaXkZcp6TZvVOJzXPOi84cpQ6PHbhw@mail.gmail.com>
 <20200406095124.GA475759@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46218 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDILmR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 07:42:17 -0400
In-Reply-To: <20200406095124.GA475759@ulmo>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Clemens Gruber <clemens.gruber@pqgruber.com>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On Mon, Apr 6, 2020 at 5:51 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> There are other chips where a single period is shared across multiple
> PWM channels. Typically what we do there is once a period is configured
> for a given channel, all subsequent PWM channel configurations must use
> the same period, or otherwise the driver will return an error code.

Thank you for the clarification Thierry. Do you think this method would be
appropriate for this chip?
