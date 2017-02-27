From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 8/9] pwm: sunxi: Code cleanup.
Date: Mon, 27 Feb 2017 10:32:31 +0100
Message-ID: <20170227093231.tfdbxp7yybd6hd6l@lukather>
References: <1487914876-8594-1-git-send-email-lis8215@gmail.com>
 <1487914876-8594-9-git-send-email-lis8215@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ybi5zhlts37wska3"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBMHEZ7CQKGQEM3AOVXA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1487914876-8594-9-git-send-email-lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org


--ybi5zhlts37wska3
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, Feb 24, 2017 at 08:41:15AM +0300, lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> This patch removes macros, which are not use anymore and
> fixes two extra -Wsign-compare warnings.
> 
> Signed-off-by: Siarhei Volkau <lis8215-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

You've been adding this code in your previous patches, why is that
even added there?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--ybi5zhlts37wska3--
