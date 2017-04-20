From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4 1/1] pwm: pca9685: fix gpio-only operation.
Date: Thu, 20 Apr 2017 18:55:34 +0300
Message-ID: <20170420155534.GF7152@lahna.fi.intel.com>
References: <1492088291-5215-1-git-send-email-svenv@arcx.com>
 <1492088291-5215-2-git-send-email-svenv@arcx.com>
 <1492506852.24567.54.camel@linux.intel.com>
 <CAGngYiWj1jBsgYAL31Qb2Ne+Te34vpjWD14xbV+u9vRS0i8kkQ@mail.gmail.com>
 <CAHp75VdaDP8GZGz5ZkKpSDdszjRzA+Miw=K7d_g3aeKTN4Ce=A@mail.gmail.com>
 <CAGngYiXHaDxbz9jpc=P4kT6n2yKHRmFznuse3beWXi35JCK8Yw@mail.gmail.com>
 <CAHp75VcOb1_kvNNP5Ptp5e_8-ipHLM5Oy6W-_pv=GcUNiz0XVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:4274 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S946532AbdDTPzk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 20 Apr 2017 11:55:40 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VcOb1_kvNNP5Ptp5e_8-ipHLM5Oy6W-_pv=GcUNiz0XVQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sven Van Asbroeck <TheSven73@googlemail.com>

On Thu, Apr 20, 2017 at 06:07:37PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 20, 2017 at 5:12 PM, Sven Van Asbroeck <thesven73@gmail.com> wrote:
> >> Taking above into consideration perhaps sleep is not quite good word
> >> at all. By functional description it sounds like latency tolerance to
> >> me.
> >
> > That's true, but the bit description in the chip datasheet is 'SLEEP'.
> > (its real function is suspend/low power, but the chip designers called
> > it 'SLEEP')
> >
> > Calling the bit/function something else is likely to confuse someone
> > who's reading the driver in combination with the chip datasheet.
> 
> Looking again into the patch I have noticed:
> 1) word 'sleep' is used as a part of a function name;
> 2) int sleep is used as binary value.
> 
> Thus, I would suggest: int sleep -> bool enable (or alike).
> 
> Would we agree on that?

That sounds good to me. I guess it will have to be an incremental patch
since this one has already been applied.
