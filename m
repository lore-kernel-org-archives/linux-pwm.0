Return-Path: <olof@lixom.net>
MIME-Version: 1.0
In-Reply-To: <0ac901ce867f$638a7530$2a9f5f90$@org>
References: <1374278673-25615-1-git-send-email-tomasz.figa@gmail.com>
	<51EC5F18.8040007@gmail.com>
	<9102768.ef8LAvpunv@flatron>
	<0ac901ce867f$638a7530$2a9f5f90$@org>
Date: Mon, 22 Jul 2013 12:34:59 -0700
Message-ID: <CAOesGMixczupXEv-iz2nd2GM0i5DTQvVaF2DqjFnDBqsCNKCYQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/20] Samsung PWM support cleanup
From: Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pwm.vger.kernel.org>
To: Kukjin Kim <kgene@kernel.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>

On Sun, Jul 21, 2013 at 7:01 PM, Kukjin Kim <kgene@kernel.org> wrote:

>> Yes, this whole patches look good to me, and I'd like to take this whole
>> patches into the samsung tree...but need to get any response from PWM guy,
>> Thierry Reding. Let's wait for his response...
>>
> To be clarify, because his ack was on v3 and I remember he had a comment. So
> would be better if we could get his ack on pwm change again.
>
> Thanks,
> Kukjin
>

This is a nice cleanup series indeed.

Given the volume of changes coming from Tomasz, it seems appropriate
that he just sends you pull requests with this as a branch when they
are ready to go (i.e. have the appropriate acks), instead of you
having to apply them by hand, Kukjin.


-Olof
