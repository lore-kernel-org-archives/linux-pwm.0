From: "cas" <cas@matrixfiles.com>
Subject: Re: [PATCH 4/8] mfd: stm32-timers: add support for dmas
Date: Wed, 24 Jan 2018 10:43:37 -0500
Message-ID: <4E69ABAE738243638F41986C65034974@toshiba>
References: <1516106631-18722-1-git-send-email-fabrice.gasnier@st.com>
 <1516106631-18722-5-git-send-email-fabrice.gasnier@st.com>
 <20180123133234.xmep76cgdremnj47@dell>
 <e611b40f-bd37-aa2d-afd9-997b86d55441@st.com>
 <20180123153035.2rvhspe2m5ej57op@dell>
 <ee021839-3298-d01b-8890-619aca0399a7@st.com>
 <20180123164121.xjzhypqe2u5c7zza@dell>
 <2e6afc46-9ad4-a858-29c7-692798ece82f@st.com>
 <20180124145633.tnblnqau7ncju7dp@dell>
 <0c6a185c-cc12-38ae-3909-5c0e82f8da3f@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>, Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: mark.rutland@arm.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, devicetree@vger.kernel.org, linux@armlinux.org.uk, robh+dt@kernel.org, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, linux-pwm@vger.kernel.org, benjamin.gaignard@linaro.org, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: linux-pwm@vger.kernel.org

Apologies for interrupting any work/messages being undertaken. I am a newbie 
here (1st post) and felt this was the only way to get this information to 
Linus Torvalds.
____
The following was posted on a forum on the 22nd March 2017:

'I've been working at Intel for the last 15 years as an electrical engineer. 
3 years ago I [got] bored with my job and wanted to move to a different 
department. Intel is pretty good about letting employees move around within 
the company. An opening came up on the Management Engine team, and since I 
have experience with micro-controllers I figured I'd give it a shot. The 
interview went great and they wanted me on board, but the final step was to 
get securuty clearance.

I asked them WTF I need a security clearance for, and they said they 
couldn't tell me unitl I was on the team. Thus began a 3 year trip down the 
fucking rabbit hole.

I'm coming forward today because of the news that Trump was spied on. I know 
exactly how it was done because I spent the last three years adding 
backdoors into the ME. For those of you that are unaware, the ME is ona 
separate CPU and cannot be disabled, and it exists at a level below the 
operating system. Intel has been working with the intelligence community for 
years to get backdoors into physical hardware so they don't have to worry 
about finding OS exploits. If the hardware itself is compromised then the 
whole machine is compromised.

----Next post----

The ME has full access to memory without the parent CPU having any 
knowledge, it has full access to the TCP/IP stacl, and full access to every 
peripheral connected to the computer. It also runs when the computer is 
hibernating. It doesn't matter if you're using Windows, Linux, Mac OS X, 
Whonix, Tails, Qubes OS, or Subgraph. If you have an i3, i5, or i7 hen 
you're completely owned by the intelligence community.

We added similar finctionality to Samsung's WEEPING ANGEL, except the 
intelligence community calls our project ODIN'S EYE. Through the ME we can 
activate the mic and webcam even though the computer appears to be off or 
sleeping.

Evidence of surveillance on Trump, his family, and key people in his 
campaign will come out eventually. I know the surveillance happened for a 
fact. Future leaks are coming, watch out for ODIN'S EYE.'

---END POST---

Jim Stone over at

82.221.129.208/.zj3.html

has the image of the text of the above (you need to scroll down a bit). He 
also mentioned this stuff, and more, over 7 years ago, though not in the 
same exact terms as the above, and states that this has actually occured 
since the Centrino processor, which is where the first backdoors started to 
be placed.

I am here to pass on the information to all of you, if you do not already 
have it (and since I have just joined to explicitly to send this I have no 
idea if any of you know this or not), and primarily to get this information 
to Linus Torvalds who has been quoted by RT very recently as saying that the 
patches announced by intel (for the Spectre and Meltdown bug) are 'garbage'.

I hope that the above information can now be used to understand the real 
extent of the problem.

[Note: if one is not able to find the image of the text at the above site 
you can find it here:

liferepairspecialist.com/Memes/

look for the image called 'inteladmission' - it is in this folder and not in 
any subfolders.] 
