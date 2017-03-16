From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 4/7] macintosh: Only descend into directory when
 CONFIG_MACINTOSH_DRIVERS is set
Date: Thu, 16 Mar 2017 15:28:36 +1100
Message-ID: <87var9u9or.fsf@concordia.ellerman.id.au>
References: <20170315163730.17055-1-afd@ti.com>
 <20170315163730.17055-5-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20170315163730.17055-5-afd@ti.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Richard Purdie <rpurdie@rpsys.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Lauro Ramos Venancio <lauro.venancio@openbossa.org>, Aloisio Almeida Jr <aloisio.almeida@openbossa.org>, Samuel Ortiz <sameo@linux.intel.com>, kernel-janitors@vger.kernel.org
Cc: linux-pwm@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, linuxppc-dev@lists.ozlabs.org, linux-media@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

"Andrew F. Davis" <afd@ti.com> writes:

> When CONFIG_MACINTOSH_DRIVERS is not set make will still descend into the
> macintosh directory but nothing will be built. This produces unneeded
> build artifacts and messages in addition to slowing the build.
> Fix this here.
>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
>  drivers/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheersj
