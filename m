From: Paul Barker <pbarker-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 3/7] dt-bindings: pwm: add normal PWM polarity flag
Date: Tue, 17 Mar 2020 13:36:38 +0000
Message-ID: <20200317133638.5951a743@ub1910>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
        <20200317123231.2843297-4-oleksandr.suvorov@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200317123231.2843297-4-oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Marcel Ziswiler <marcel.ziswiler-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Igor Opaniuk <igor.opaniuk-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Philippe Schenker <philippe.schenker-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

On Tue, 17 Mar 2020 14:32:27 +0200
Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org> wrote:

> PWM can have a normal polarity and a reverted one. The reverted polarity
> value is defined.
> Define the PWM_POLARITY_NORMAL to be used further.
> 
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>

s/reverted/inverted/

-- 
Paul Barker
Konsulko Group
