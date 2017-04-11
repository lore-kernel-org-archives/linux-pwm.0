From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH 1/1] pwm: pca9685: fix gpio-only operation.
Date: Mon, 10 Apr 2017 23:35:39 -0400
Message-ID: <CAGngYiVpWa9qrTFn9BmTahgyBZDsX22vjfjL=4JZUMV9W+nxmw@mail.gmail.com>
References: <1491754284-3870-1-git-send-email-svenv@arcx.com>
 <1491754284-3870-2-git-send-email-svenv@arcx.com> <20170410103320.GG2957@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:33477 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbdDKDfk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Apr 2017 23:35:40 -0400
In-Reply-To: <20170410103320.GG2957@lahna.fi.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, clemens.gruber@pqgruber.com, andriy.shevchenko@linux.intel.com, Sven Van Asbroeck <TheSven73@googlemail.com>

> How about implementing a real runtime PM in the driver? Then when the
> device is idle regardless of whether it is GPIO or PWM, the SLEEP bit is
> set and cleared accordingly.

You mean: increase the runtime_pm refcnt when a pwm/gpio is enabled,
and vice versa ? And don't touch the refcnt on pwm/gpio export/unexport?

Neat. I will test such a solution and try to post it within the next few days.
