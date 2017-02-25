From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] pwm: sunxi: Add A64 support
Date: Sat, 25 Feb 2017 05:00:42 -0800 (PST)
Message-ID: <707e07e8-9836-4a21-bef7-a2487cd86246@googlegroups.com>
References: <20170225074216.64868-1-icenowy@aosc.xyz> <20170225074216.64868-2-icenowy@aosc.xyz> <CAGb2v67OaUps1yffyZ8pBvMwbAU+6WC2pPkt25e5i+SYU1nrDw@mail.gmail.com>
 <870861488014589@web9m.yandex.ru>
Reply-To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_488_275470778.1488027642573"
Return-path: <linux-sunxi+bncBDJLROMN3MJRB677YXCQKGQET3AOISI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <870861488014589-IyhJ2jtAr7tuio3avFS2gg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Cc: wens-jdAy2FN1RRM@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

------=_Part_488_275470778.1488027642573
Content-Type: multipart/alternative;
	boundary="----=_Part_489_870088641.1488027642573"

------=_Part_489_870088641.1488027642573
Content-Type: text/plain; charset=UTF-8

> H3 is also same as A13... 

According to datasheets/user manuals H3 has 2 PWM channels, but A64 
has only one channel, so A13 compatible string is preferred.
------=_Part_489_870088641.1488027642573--

------=_Part_488_275470778.1488027642573--
