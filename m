From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [PATCH v4 1/1] pwm: pca9685: fix gpio-only operation.
Date: Thu, 20 Apr 2017 10:12:23 -0400
Message-ID: <CAGngYiXHaDxbz9jpc=P4kT6n2yKHRmFznuse3beWXi35JCK8Yw@mail.gmail.com>
References: <1492088291-5215-1-git-send-email-svenv@arcx.com>
 <1492088291-5215-2-git-send-email-svenv@arcx.com> <1492506852.24567.54.camel@linux.intel.com>
 <CAGngYiWj1jBsgYAL31Qb2Ne+Te34vpjWD14xbV+u9vRS0i8kkQ@mail.gmail.com> <CAHp75VdaDP8GZGz5ZkKpSDdszjRzA+Miw=K7d_g3aeKTN4Ce=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mail-io0-f170.google.com ([209.85.223.170]:36447 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032276AbdDTOMu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Apr 2017 10:12:50 -0400
In-Reply-To: <CAHp75VdaDP8GZGz5ZkKpSDdszjRzA+Miw=K7d_g3aeKTN4Ce=A@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sven Van Asbroeck <TheSven73@googlemail.com>

> Taking above into consideration perhaps sleep is not quite good word
> at all. By functional description it sounds like latency tolerance to
> me.

That's true, but the bit description in the chip datasheet is 'SLEEP'.
(its real function is suspend/low power, but the chip designers called
it 'SLEEP')

Calling the bit/function something else is likely to confuse someone
who's reading the driver in combination with the chip datasheet.
