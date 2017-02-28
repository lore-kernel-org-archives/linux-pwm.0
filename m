From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 8/9] pwm: sunxi: Code cleanup.
Date: Tue, 28 Feb 2017 16:49:05 +0100
Message-ID: <20170228154905.ru6joyj4he2ohaws@lukather>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
 <1487914876-8594-9-git-send-email-lis8215@gmail.com>
 <20170227093231.tfdbxp7yybd6hd6l@lukather>
 <CAKNVLfZ_eHQPu0mbQ9LkOfSO+tKMt+ExUj-VcE-tBn65_D2J=Q@mail.gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p7ltu3eyqzxq2bl4"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB7FX23CQKGQE5FAFOOQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <CAKNVLfZ_eHQPu0mbQ9LkOfSO+tKMt+ExUj-VcE-tBn65_D2J=Q@mail.gmail.com>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--p7ltu3eyqzxq2bl4
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Feb 27, 2017 at 04:21:49PM +0300, Siarhei Volkau wrote:
> Hi,
> 
> 2017-02-27 12:32 GMT+03:00 Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>:
> > On Fri, Feb 24, 2017 at 08:41:15AM +0300, lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> >> From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >>
> >> This patch removes macros, which are not use anymore and
> >> fixes two extra -Wsign-compare warnings.
> >>
> >> Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >
> > You've been adding this code in your previous patches, why is that
> > even added there?
> >
> > Maxime
> >
> > --
> > Maxime Ripard, Free Electrons
> > Embedded Linux and Kernel engineering
> > http://free-electrons.com
> 
> Are you mean there are no needs in separate patch for that?

Yes

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--p7ltu3eyqzxq2bl4--
