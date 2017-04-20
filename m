From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 1/1] pwm: pca9685: fix gpio-only operation.
Date: Thu, 20 Apr 2017 19:13:11 +0300
Message-ID: <1492704791.24567.104.camel@linux.intel.com>
References: <1492088291-5215-1-git-send-email-svenv@arcx.com>
         <1492088291-5215-2-git-send-email-svenv@arcx.com>
         <1492506852.24567.54.camel@linux.intel.com>
         <CAGngYiWj1jBsgYAL31Qb2Ne+Te34vpjWD14xbV+u9vRS0i8kkQ@mail.gmail.com>
         <CAHp75VdaDP8GZGz5ZkKpSDdszjRzA+Miw=K7d_g3aeKTN4Ce=A@mail.gmail.com>
         <CAGngYiXHaDxbz9jpc=P4kT6n2yKHRmFznuse3beWXi35JCK8Yw@mail.gmail.com>
         <CAHp75VcOb1_kvNNP5Ptp5e_8-ipHLM5Oy6W-_pv=GcUNiz0XVQ@mail.gmail.com>
         <CAGngYiW7wASpqf-h9fieDV8ctd61=8WqBs=8n1NJ-jSm0uULrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGngYiW7wASpqf-h9fieDV8ctd61=8WqBs=8n1NJ-jSm0uULrw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sven Van Asbroeck <thesven73@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pwm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sven Van Asbroeck <TheSven73@googlemail.com>
List-Id: linux-pwm@vger.kernel.org

On Thu, 2017-04-20 at 11:50 -0400, Sven Van Asbroeck wrote:
> > Thus, I would suggest: int sleep -> bool enable (or alike).
> > 
> > Would we agree on that?
> 
> I would. Perhaps also:
> set_sleep_mode(int sleep) -> enable_sleep_mode(bool enable) ?

I'm okay with a such (don't forget to change 0/1 in call sites to
false/true as well).

> Let's see what Mika and Thierry think.

I suppose Mika's answer is an acknowledge to the change.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
