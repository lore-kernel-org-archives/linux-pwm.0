From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: Add "sifive" vendor prefix
Date: Tue, 1 May 2018 11:14:39 -0500
Message-ID: <20180501161439.GA28644@rob-hp-laptop>
References: <1524869998-2805-1-git-send-email-wesley@sifive.com>
 <1524869998-2805-3-git-send-email-wesley@sifive.com>
 <72c263ef-09c3-a05f-3c16-1bc8df667d38@suse.de>
 <CAMgXwThXvdzi27GjTD-q4Fw7kM5WOCtMewh7U3M4wcLwEx+VQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMgXwThXvdzi27GjTD-q4Fw7kM5WOCtMewh7U3M4wcLwEx+VQw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wesley Terpstra <wesley@sifive.com>
Cc: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>, David Lechner <david@lechnology.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, SZ Lin <sz.lin@moxa.com>, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

On Sat, Apr 28, 2018 at 10:37:56PM +0000, Wesley Terpstra wrote:
> Will do, thanks!

Don't top post to lists.

I've applied this. I assume you'll have things other than the PWM...
 
> On Sat, Apr 28, 2018, 4:21 AM Andreas Färber <afaerber@suse.de> wrote:
> 
> > Am 28.04.2018 um 00:59 schrieb Wesley W. Terpstra:
> > > This adds a vendor prefix "sifive" for SiFive, Inc.
> > > We make chips.
> > >
> > > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
> > > ---
> > >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > Reviewed-by: Andreas Färber <afaerber@suse.de>
> >
> > but please reorder the patches, so that the prefix definition comes
> > before its first use in the pwm binding.
> >
> > Regards,
> > Andreas
> >
> > --
> > SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> > GF: Felix Imendörffer, Jane Smithard, Graham Norton
> > HRB 21284 (AG Nürnberg)
> >
