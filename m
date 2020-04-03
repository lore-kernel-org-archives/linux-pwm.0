From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v2 REBASED] pwm: pca9685: fix pwm/gpio inter-operation
Date: Fri, 3 Apr 2020 11:24:01 -0400
Message-ID: <CAGngYiXy5-REGTnUgrFDHdbskX7FkkO2UBkGok8NOSc14RQf5Q@mail.gmail.com>
References: <20200401170106.134037-1-clemens.gruber@pqgruber.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42023 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403989AbgDCPYN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Apr 2020 11:24:13 -0400
In-Reply-To: <20200401170106.134037-1-clemens.gruber@pqgruber.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wed, Apr 1, 2020 at 1:01 PM Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:
>
> From: Sven Van Asbroeck <TheSven73@gmail.com>
>
> Tested-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> [cg: Tested on an i.MX6Q board with two NXP PCA9685 chips]

Thank you Clemens for testing and rebasing this patch, much appreciated !

The synchronization method introduced here still looks correct to me. So:

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com> # cg's rebase
